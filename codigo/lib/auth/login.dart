import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:myapp/auth/forgotPassword.dart';
import 'package:myapp/auth/signUp.dart';
import 'package:myapp/events/homepage.dart';
import 'package:myapp/utils.dart' show SafeGoogleFont;

class Login extends StatefulWidget {
  @override
  _EmailPassPage createState() => _EmailPassPage();
}

class _EmailPassPage extends State<Login> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormBuilderState>();
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
        backgroundColor: Colors.purple,
      ),
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
                            labelStyle: TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
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
                            labelStyle: TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
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
                          labelStyle: TextStyle(color: Colors.purple),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'admin',
                            child: const Text('Administrador'),
                          ),
                          DropdownMenuItem(
                            value: 'user',
                            child: const Text('Usuário'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle dropdown value change
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [Color(0xff9586a8), Color(0xff0bce83)],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: TextButton(
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.saveAndValidate()) {
                                try {
                                  await auth.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passController.text,
                                  );
                                  setState(() {
                                    logado = true;
                                  });
                                  final formData = _formKey.currentState!.value;
                                  final selectedRole = formData['role'];
                                  if (selectedRole == 'admin') {
                                    // Redirecionar para a tela do administrador
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => AdminScreen()),
                                      ),
                                    );
                                  } else {
                                    // Redirecionar para a tela do usuário
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => UserScreen()),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Email ou senha errados. Verifique suas informações e tente novamente.',
                                      ),
                                    ),
                                  );
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
                              color: Color(0xff9586a8),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ForgotPassword()),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Exemplo de tela para o administrador
class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela do Administrador"),
      ),
      body: const Center(
        child: Text("Bem-vindo, Administrador!"),
      ),
    );
  }
}

// Exemplo de tela para o usuário
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela do Usuário"),
      ),
      body: const Center(
        child: Text("Bem-vindo, Usuário!"),
      ),
    );
  }
}
