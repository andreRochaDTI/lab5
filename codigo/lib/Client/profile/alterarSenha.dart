import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  String? _errorMessage;

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _currentPasswordController.text,
          );
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(_newPasswordController.text);
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: const Color(0xFF4527A0),
                content: const Text(
                  'Senha alterada com sucesso',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Fechar',
                      style: TextStyle(
                        color: const Color(0xFF4527A0),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _errorMessage = 'Usuário não autenticado.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Erro ao alterar a senha: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Senha'),
        backgroundColor: const Color(0xFF4527A0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha atual'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a senha atual';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Nova senha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a nova senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmNewPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirmar nova senha'),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4527A0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: _changePassword,
                child: const Text('Alterar Senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
