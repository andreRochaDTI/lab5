import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../events/homepage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData;

    mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    if (FirebaseAuth.instance.currentUser != null) {
      logado = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-VENTO"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: logado
          ? Column(
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
                          end: Alignment.bottomRight),
                    ),
                    child: TextButton(
                      child: const Center(
                          child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      },
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                                borderSide:
                                    BorderSide(color: Color(0xff0bce83)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0bce83)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                    const SizedBox(
                      height: 20,
                    ),
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
                                borderSide:
                                    BorderSide(color: Color(0xff0bce83)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0bce83)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                    const SizedBox(
                      height: 20,
                    ),
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
                                labelStyle:
                                    const TextStyle(color: Color(0xff0bce83)),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff0bce83)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff0bce83)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
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
                                )),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: screenWidth * 0.15,
                      child: Form(
                          key: _formKeyPass2,
                          child: TextFormField(
                            controller: _pass2Controller,
                            keyboardType: TextInputType.text,
                            obscureText: !passwordVisible2,
                            validator: (text) {
                              if (_passController.text !=
                                  _pass2Controller.text) {
                                return 'As senhas não coincidem';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Repita a senha",
                                labelStyle:
                                    const TextStyle(color: Color(0xff0bce83)),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff0bce83)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff0bce83)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
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
                                )),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          )),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                              colors: [Color(0xff0bce83), Color(0xff0bce83)],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: TextButton(
                          child: const Center(
                              child: Text(
                            "Cadastrar",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                          onPressed: () {
                            if (_formKeyName.currentState!.validate() &&
                                _formKeyEmail.currentState!.validate() &&
                                _formKeyPass.currentState!.validate() &&
                                _formKeyPass2.currentState!.validate()) {
                              //SignUp
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passController.text)
                                  .then((value) {
                                setState(() {
                                  logado = true;
                                });
                              }).catchError((e) => print(e.toString()));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
