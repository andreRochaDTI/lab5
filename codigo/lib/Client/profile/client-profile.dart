import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Client/events/client-homepage.dart';
import 'package:myapp/Admin/profile/alterarSenha.dart';
import 'package:myapp/Client/utils/maps.dart';

import '../../auth/about-us.dart';
import '../../auth/login.dart';
import 'editarPefil.dart';

class ClientProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar perfil'));
          }

          final userData = snapshot.data?.data();

          return Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(userData?['imageURL'] ?? ''),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData?['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData?['email'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 0.1,
                      ),
                    ),
                    width: double.infinity,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Editar Perfil',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10.0),
                const Text(
                  'Minha Conta',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordPage(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Alterar Senha',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => About(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Sobre nós',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sair'),
                          content: const Text(
                              'Tem certeza que deseja desconectar sua conta?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Sair'),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Sair da Conta',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientHomePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.map, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClientMapPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.deepPurple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientProfilePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.event, color: Colors.deepPurple),
              onPressed: () {
                // Navegue para a página de ingressos aqui
              },
            ),
          ],
        ),
      ),
    );
  }
}
