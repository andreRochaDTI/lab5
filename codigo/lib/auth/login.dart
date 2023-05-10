import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/forgotPassword.dart';
import 'package:myapp/auth/signUp.dart';
import 'package:myapp/events/homepage.dart';
import 'package:myapp/utils.dart' show SafeGoogleFont;
import 'package:myapp/services/login.dart';

class Login extends StatefulWidget {
  @override
  _EmailPassPage createState() => _EmailPassPage();
}

class _EmailPassPage extends State<Login> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool logado = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;

    _mediaQueryData = MediaQuery.of(context);
    double screenWidth = _mediaQueryData.size.width;
    double screenHeight = _mediaQueryData.size.height;

    if (FirebaseAuth.instance.currentUser != null) {
      logado = true;
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
          title: const Text("E-vento"),
          centerTitle: true,
          backgroundColor: Colors.purple),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: screenWidth * 0.15,
                      child: Form(
                        key: _formKeyEmail,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          validator: (text) {
                            if (text!.isEmpty || !text.contains('@')) {
                              return "Email inválido";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
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
                            decoration: InputDecoration(
                                labelText: "Senha",
                                labelStyle:
                                    const TextStyle(color: Colors.purple),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.purple,
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
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        height: screenHeight * 0.065,
                        width: screenWidth * 0.50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                              colors: [Color(0xff9586a8), Color(0xff0bce83)],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: TextButton(
                          child: const Center(
                              child: Text(
                            "Login",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          )),
                          onPressed: () async {
                            if (_formKeyEmail.currentState!.validate() &&
                                _formKeyPass.currentState!.validate()) {
                              try {
                                await auth.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passController.text);
                                setState(() {
                                  logado = true;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => HomePage())));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Email ou senha errados. Verifique suas informações e tente novamente.'),
                                ));
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: InkWell(
                          child: const Text(
                            "Esqueceu a senha?",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff9586a8)),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ForgotPassword())));
                          },
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
