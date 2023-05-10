import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _newPassController = TextEditingController();
  final _newPass2Controller = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKeyNewPass = GlobalKey<FormState>();
  final _formKeyNewPass2 = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool newPasswordVisible = false;
  bool newPasswordVisible2 = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData;

    _mediaQueryData = MediaQuery.of(context);
    double screenWidth = _mediaQueryData.size.width;
    double screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Auth"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: screenWidth * 0.15,
              child: Form(
                  key: _formKeyPass,
                  child: TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.text,
                    obscureText: !passwordVisible,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6)
                        return 'Senha inválida';
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Senha Atual",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        )),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: screenWidth * 0.15,
              child: Form(
                  key: _formKeyNewPass,
                  child: TextFormField(
                    controller: _newPassController,
                    keyboardType: TextInputType.text,
                    obscureText: !newPasswordVisible,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6)
                        return "Senha inválida";
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Nova Senha",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            newPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              newPasswordVisible = !newPasswordVisible;
                            });
                          },
                        )),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: screenWidth * 0.15,
              child: Form(
                  key: _formKeyNewPass2,
                  child: TextFormField(
                    controller: _newPass2Controller,
                    keyboardType: TextInputType.text,
                    obscureText: !newPasswordVisible2,
                    validator: (text) {
                      if ((text!.isEmpty || text.length < 6) ||
                          _newPassController.text != _newPass2Controller.text)
                        return 'As senhas não coincidem';
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Repita a nova senha",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            newPasswordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              newPasswordVisible2 = !newPasswordVisible2;
                            });
                          },
                        )),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: screenHeight * 0.065,
              width: screenWidth * 0.50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                    colors: [Color(0xFF6a7bd9), Color(0xff3f51b5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight),
              ),
              child: TextButton(
                onPressed: () {
                  if (_formKeyPass.currentState!.validate() &&
                      _formKeyNewPass.currentState!.validate() &&
                      _formKeyNewPass2.currentState!.validate()) {
                    // Att Senha
                    User? user = FirebaseAuth.instance.currentUser;
                    AuthCredential credential = EmailAuthProvider.credential(
                        email: 'user?.email', password: _passController.text);
                    user
                        ?.reauthenticateWithCredential(credential)
                        .then((value) {
                      user
                          .updatePassword(_newPassController.text)
                          .then(
                              (value) => print("Senha atualizada com sucesso!"))
                          .catchError((e) => print(e.toString()));
                    }).catchError((e) => print(e.toString()));
                  }
                },
                child: const Text(
                  "Atualizar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
