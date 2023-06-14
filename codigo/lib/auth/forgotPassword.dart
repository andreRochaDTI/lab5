import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;

    _mediaQueryData = MediaQuery.of(context);
    double screenWidth = _mediaQueryData.size.width;
    double screenHeight = _mediaQueryData.size.height;

    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Insira seu email para recuperar a senha",
                style: TextStyle(fontSize: 18, color: Color(0xFF4527A0)),
              ),
              const SizedBox(height: 20),
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
                            labelStyle: TextStyle(color: Color(0xFF4527A0)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF4527A0)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF4527A0)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
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
                    Container(
                      height: screenHeight * 0.065,
                      width: screenWidth * 0.50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          colors: [Color(0xFF4527A0), Color(0xFF4527A0)],
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: TextButton(
                        child: const Text(
                          'Recuperar senha',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        onPressed: () {
                          _formKeyPass.currentState?.reset();
                          if (_formKeyEmail.currentState!.validate()) {
                            auth
                                .fetchSignInMethodsForEmail(
                                    _emailController.text)
                                .then((providers) {
                              if (providers.isNotEmpty) {
                                auth
                                    .sendPasswordResetEmail(
                                        email: _emailController.text)
                                    .then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Link para recuperação do email enviado.'),
                                  ));
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Erro ao enviar link de recuperação de senha: $error'),
                                  ));
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Email não encontrado. Verifique se o endereço de email está correto ou crie uma nova conta.'),
                                ));
                              }
                            }).catchError((error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Erro ao verificar o email: $error'),
                              ));
                            });
                          }
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: const Text(
                        "Entrar",
                        style:
                            TextStyle(color: Color(0xFF4527A0), fontSize: 20),
                      ),
                    ),
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
