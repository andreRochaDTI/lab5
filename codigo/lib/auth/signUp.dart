import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../events/homepage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _pass2Controller = TextEditingController();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKeyPass2 = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool passwordVisible2 = false;
  bool logado = false;
  File? _image;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData;

    mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    if (FirebaseAuth.instance.currentUser != null) {
      logado = true;
    }

    Future<void> uploadImageToFirebase(File imageFile, String uid) async {
      try {
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child('$uid.jpg');
        await ref.putFile(imageFile);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-VENTO"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body:
          /*? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Cadastro feito com sucesso!",
                  style: TextStyle(fontSize: 23, color: Colors.green),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: screenHeight * 0.06,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.green],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: TextButton(
                      child: const Center(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => HomePage()),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          :*/
          Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Stack(
                  children: [
                    if (_image != null)
                      ClipOval(
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final pickedImage = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {
                            if (pickedImage != null) {
                              _image = File(pickedImage.path);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: screenWidth * 0.15,
                child: Form(
                  key: _formKeyName,
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      labelStyle: TextStyle(color: Color(0xff0bce83)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (text) {
                      if (text!.isEmpty || text.length < 10) {
                        return 'Nome inválido';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: screenWidth * 0.15,
                child: Form(
                  key: _formKeyEmail,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Color(0xff0bce83)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (text) {
                      if (text!.isEmpty || !text.contains('@')) {
                        return 'Email inválido';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: screenWidth * 0.15,
                child: Form(
                  key: _formKeyPass,
                  child: TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.text,
                    obscureText: !passwordVisible,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        return 'Senha inválida';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(
                        color: Color(0xff0bce83),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xff0bce83),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: screenWidth * 0.15,
                child: Form(
                  key: _formKeyPass2,
                  child: TextFormField(
                    controller: _pass2Controller,
                    keyboardType: TextInputType.text,
                    obscureText: !passwordVisible2,
                    validator: (text) {
                      if (_passController.text != _pass2Controller.text) {
                        return 'As senhas não coincidem';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Confirmar senha",
                      labelStyle: const TextStyle(
                        color: Color(0xff0bce83),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0bce83)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xff0bce83),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible2 = !passwordVisible2;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: TextButton(
                  child: const Center(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKeyName.currentState!.validate() &&
                        _formKeyEmail.currentState!.validate() &&
                        _formKeyPass.currentState!.validate() &&
                        _formKeyPass2.currentState!.validate()) {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passController.text,
                        );
                        if (userCredential.user != null) {
                          final User? user = FirebaseAuth.instance.currentUser;
                          final String uid = user!.uid;
                          final String name = _nameController.text;
                          final String email = _emailController.text;
                          final String password = _passController.text;
                          // Upload image to Firebase Storage
                          String imagePath = 'users/$uid/profile_picture.jpg';
                          Reference storageReference =
                              FirebaseStorage.instance.ref().child(imagePath);
                          UploadTask uploadTask =
                              storageReference.putFile(_image!);
                          await uploadTask.whenComplete(() async {
                            // Get image URL
                            String imageURL =
                                await storageReference.getDownloadURL();
                            // Save user data to Firestore
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .set({
                              'name': name,
                              'email': email,
                              'password': password,
                              'imageURL': imageURL,
                            }).then((value) {
                              setState(() {
                                logado = true;
                              });
                            }).catchError((error) {
                              print("Failed to add user data: $error");
                            });
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
