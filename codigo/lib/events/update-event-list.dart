import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:myapp/events/homepage.dart';

class UpdateEvent extends StatefulWidget {
  final String id;

  UpdateEvent({required this.id});

  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  File? _imageFile;
  bool _uploading = false;
  bool _imageSelected = false;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  Future<void> _uploadImage() async {
    setState(() {
      _uploading = true;
    });

    try {
      if (_imageFile == null) {
        throw Exception('Image file is null');
      }

      final fileName = _imageFile!.path.split('/').last;
      final destination = '${widget.id}/$fileName';
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_imageFile!);

      final imageUrl = await ref.getDownloadURL();

      // Save the event to Firestore
      final event = {
        'name': _nameController.text,
        'address': _addressController.text,
        'image': imageUrl,
        'date': _dateController.text,
        'time': _timeController.text,
      };
      await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.id)
          .set(event);

      _nameController.clear();
      _addressController.clear();
      _dateController.clear();
      _timeController.clear();
      setState(() {
        _imageFile = null;
        _uploading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _uploading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_uploading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload de Evento'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  height: 200.0,
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
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(_imageSelected
                    ? 'Imagem selecionada'
                    : 'Selecionar imagem'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do evento',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Endereço',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _dateController,
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2030, 12, 31),
                    onChanged: (date) {
                      // Será chamado quando a data for alterada
                      _dateController.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    },
                    onConfirm: (date) {
                      // Será chamado quando a data for confirmada
                      _dateController.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType
                        .pt, // Defina o idioma para português, se necessário
                  );
                },
                decoration: const InputDecoration(
                  labelText: 'Data do evento',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _timeController,
                onTap: () async {
                  final TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );

                  if (selectedTime != null) {
                    final formattedTime = DateFormat.Hm().format(DateTime(
                        2022, 1, 1, selectedTime.hour, selectedTime.minute));
                    _timeController.text = formattedTime;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Horário do evento',
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _uploading
                    ? null
                    : () async {
                        await _uploadImage();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: _uploading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
