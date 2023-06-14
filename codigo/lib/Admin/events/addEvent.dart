import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Admin/events/admin-homepage.dart';
import 'package:myapp/Admin/profile/profile.dart';
import 'dart:convert';

import 'package:myapp/Admin/utils/admin-maps.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  File? _imageFile;
  bool _uploading = false;
  bool _imageSelected = false;

  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _addressController = TextEditingController();
  final _adressNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  Future<void> _fetchAddress() async {
    final cep = _cepController.text.replaceAll('-', '');
    final url = 'https://viacep.com.br/ws/$cep/json/';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey('erro')) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: const Text('CEP não encontrado'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        final String address =
            '${data['logradouro']}, ${data['bairro']}, ${data['localidade']}, ${data['uf']}';

        setState(() {
          _addressController.text = address;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Falha ao buscar o endereço'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _saveEventInformation() async {
    setState(() {
      _uploading = true;
    });

    try {
      if (_imageFile == null) {
        throw Exception('Image file is null');
      }

      final fileName = _imageFile!.path.split('/').last;
      final destination = 'images.imageUrl/$fileName';
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_imageFile!);

      final imageUrl = await ref.getDownloadURL();

      // Save the event to Firestore
      final event = {
        'name': _nameController.text,
        'address': _addressController.text,
        'addressNumber': _adressNumberController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'image': imageUrl,
      };
      await FirebaseFirestore.instance.collection('events').add(event);

      _nameController.clear();
      _cepController.clear();
      _addressController.clear();
      _adressNumberController.clear();
      _dateController.clear();
      _timeController.clear();
      setState(() {
        _imageFile = null;
        _uploading = false;
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _uploading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildImagePreview() {
    if (_imageFile != null) {
      return ClipRRect(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.file(
            _imageFile!,
            fit: BoxFit.cover,
            height: 200.0,
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 200.0,
          height: 200.0,
          color: Colors.grey.withOpacity(0.3),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.add,
                size: 50.0,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        _imageSelected = true;
      } else {
        _imageSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 50.0,
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _selectImage,
              child: _buildImagePreview(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                    _imageSelected = true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child:
                  Text(_imageSelected ? 'Alterar imagem' : 'Selecionar imagem'),
            ),
            const SizedBox(height: 16.0),
            Positioned(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do evento',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'CEP',
                suffixIcon: InkWell(
                  onTap: _fetchAddress,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Endereço do evento',
              ),
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _adressNumberController,
              decoration: const InputDecoration(
                labelText: 'Número do local',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime.now().add(const Duration(days: 7)),
                  maxTime: DateTime(2030, 12, 31),
                  onChanged: (date) {},
                  onConfirm: (date) {
                    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
                    setState(() {
                      _dateController.text = formattedDate;
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.pt,
                );
              },
              decoration: const InputDecoration(
                labelText: 'Data do evento',
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _timeController,
              readOnly: true,
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  showSecondsColumn: false, // Remove a coluna de segundos
                  onChanged: (time) {},
                  onConfirm: (time) {
                    final formattedTime = DateFormat('HH:mm').format(time);
                    setState(() {
                      _timeController.text = formattedTime;
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.pt,
                );
              },
              decoration: const InputDecoration(
                labelText: 'Horário do evento',
                suffixIcon: Icon(Icons.access_time, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploading ? null : _saveEventInformation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: _uploading
                  ? const CircularProgressIndicator()
                  : const Text('Adicionar evento'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminHomePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.map, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminMapPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
