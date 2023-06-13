import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Auth/login.dart';

enum UserRole {
  admin,
  client,
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKeyPass2 = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  bool passwordVisible = false;
  bool passwordVisible2 = false;
  UserRole selectedRole = UserRole.client;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 150.0,
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKeyName,
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                style: const TextStyle(fontSize: 20),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Campo obrigatório';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKeyEmail,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
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
            const SizedBox(height: 20),
            SizedBox(
              height: screenWidth * 0.15,
              child: Form(
                key: _formKeyPass,
                child: TextFormField(
                  controller: _passController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  style: const TextStyle(fontSize: 20),
                  validator: (text) {
                    if (text!.isEmpty || text.length < 6) {
                      return 'Senha inválida (mínimo 6 caracteres)';
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
                key: _formKeyPass2,
                child: TextFormField(
                  controller: _pass2Controller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !passwordVisible2,
                  decoration: InputDecoration(
                    labelText: "Confirme a senha",
                    labelStyle: const TextStyle(color: Colors.deepPurple),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible2 = !passwordVisible2;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (text) {
                    if (text != _passController.text) {
                      return 'As senhas não coincidem';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              subtitle: DropdownButtonFormField<UserRole>(
                decoration: const InputDecoration(
                  labelText: 'Função',
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: UserRole.admin,
                    child: Text('Administrador'),
                  ),
                  DropdownMenuItem(
                    value: UserRole.client,
                    child: Text('Cliente'),
                  ),
                ],
                onChanged: (UserRole? value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: screenHeight * 0.06,
              width: screenWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.deepPurple],
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

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({
                        'name': _nameController.text,
                        'role': selectedRole.toString().split('.').last,
                        'email': _emailController.text,
                        'password': _passController.text
                      });

                      showSnackBar('Cadastro realizado com sucesso');
                    } catch (e) {
                      showSnackBar('Erro ao cadastrar: $e');
                    }
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
                style: TextStyle(color: Colors.deepPurple, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
