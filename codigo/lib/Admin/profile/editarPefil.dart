import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? _user;
  late String _name;
  late String _email;
  late String _currentPassword;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  final int _nameMaxLength = 20;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _name = _user!.displayName ?? '';
    _email = _user!.email ?? '';
    _currentPassword = '';

    _nameController.text = _name;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<bool> _checkEmailExists(String email) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> _reauthenticate() async {
    try {
      final credential = EmailAuthProvider.credential(
        email: _user!.email!,
        password: _currentPassword,
      );

      await _user!.reauthenticateWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao autenticar: $e')),
      );
      return;
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _reauthenticate();

      if (_name.isNotEmpty && _name != _user!.displayName) {
        await _user!.updateDisplayName(_name);
      }

      if (_email.isNotEmpty && _email != _user!.email) {
        final emailExists = await _checkEmailExists(_email);
        if (emailExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Este email já está sendo usado')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        await _user!.updateEmail(_email);
      }

      if (_imageFile != null) {
        final imagePath = 'profile_images/${_user!.uid}.jpg';
        final imageRef = _storage.ref().child(imagePath);
        final uploadTask = imageRef.putFile(_imageFile!);
        final snapshot = await uploadTask.whenComplete(() {});
        final imageUrl = await snapshot.ref.getDownloadURL();

        await _firestore
            .collection('users')
            .doc(_user!.uid)
            .update({'imageURL': imageUrl});
      }

      await _firestore
          .collection('users')
          .doc(_user!.uid)
          .update({'name': _name, 'email': _email});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar perfil: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!) as ImageProvider<Object>?
                        : (_user!.photoURL != null
                            ? NetworkImage(_user!.photoURL!)
                            : null),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Toque na foto para alterar',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(_nameMaxLength),
              ],
              onChanged: (value) {
                setState(() {
                  _name = value.trim();
                });
              },
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Senha Atual',
              ),
              onChanged: (value) {
                setState(() {
                  _currentPassword = value.trim();
                });
              },
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_currentPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Por favor, digite a senha atual')),
                        );
                      } else {
                        _updateProfile();
                      }
                    },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
