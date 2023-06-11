import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Client/events/event-profile.dart';
import 'package:myapp/auth/login.dart';

class MyEventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Se o usuário não estiver logado, redirecionar para a tela de login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      return Container();
    }

    CollectionReference qrCodes = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('qr_codes');

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Eventos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: qrCodes.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erro ao buscar os eventos comprados.');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('Nenhum evento encontrado.');
          }

          List<DocumentSnapshot> qrCodeDocs = snapshot.data!.docs;
          List<String> eventIds = qrCodeDocs.map((doc) => doc.id).toList();

          return ListView.builder(
            itemCount: eventIds.length,
            itemBuilder: (context, index) {
              String eventId = eventIds[index];
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('events')
                    .doc(eventId)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Erro ao buscar os dados do evento.');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('Evento não encontrado.');
                  }

                  Map<String, dynamic> eventData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return ListTile(
                    leading: Image.network(
                      eventData['image'] ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(eventData['name'] ?? ''),
                    subtitle: Text(eventData['address'] ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientEventProfile(
                            id: eventId,
                            indice: index,
                            storedocs: eventIds,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
