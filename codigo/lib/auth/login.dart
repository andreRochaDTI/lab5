import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myapp/Client/events/client-homepage.dart';
import 'package:myapp/auth/forgotPassword.dart';
import 'package:myapp/auth/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Admin/events/admin-homepage.dart';

class Login extends StatefulWidget {
  @override
  _EmailPassPage createState() => _EmailPassPage();
}

class _EmailPassPage extends State<Login> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool passwordVisible = false;
  bool logado = false;
  late String? selectedRoleValue;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData;

    mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    FirebaseAuth auth = FirebaseAuth.instance;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: screenWidth * 0.15,
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira um email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Por favor, insira um email válido';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: screenWidth * 0.15,
                          child: FormBuilderTextField(
                            name: 'password',
                            controller: _passController,
                            keyboardType: TextInputType.text,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle:
                                  const TextStyle(color: Colors.deepPurple),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepPurple,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo é obrigatório';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Função',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'admin',
                              child: Text('Administrador'),
                            ),
                            DropdownMenuItem(
                              value: 'client',
                              child: Text('Cliente'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedRoleValue = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, selecione uma função';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            height: screenHeight * 0.065,
                            width: screenWidth * 0.50,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                colors: [Colors.green, Colors.deepPurple],
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: TextButton(
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  try {
                                    await auth.signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passController.text,
                                    );

                                    final userDoc = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser?.uid);

                                    final userData = await userDoc.get();

                                    if (userData.exists) {
                                      final userRole = userData.data()?['role'];

                                      if (selectedRoleValue == userRole) {
                                        if (userRole == 'admin') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminHomePage()),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClientHomePage()),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Função inválida para este usuário'),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Usuário não encontrado'),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Email ou senha incorretos'),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: const Text(
                            "Esqueci minha senha",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 17),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: const Text(
                            "Não tem uma conta? Cadastre-se!",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
