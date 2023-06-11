import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/events/homepage.dart';
import 'package:myapp/page-3/maps.dart';
import 'package:myapp/page-3/qr-generator.dart';
import 'package:myapp/utils.dart';

class EventProfile extends StatelessWidget {
  final String id;
  final int indice;
  final List storedocs;

  const EventProfile(
      {required this.id, required this.indice, required this.storedocs});

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');
    DocumentReference eventRef = events.doc(id);

    return FutureBuilder<DocumentSnapshot>(
        future: eventRef.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro ao buscar os dados do evento.');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Evento não encontrado.');
          }

          Map<String, dynamic> eventData =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            body: Stack(children: [
              Image.network(
                eventData['image'] ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
              SizedBox(
                height: double.infinity,
                child: Container(
                  margin: const EdgeInsets.only(top: 250),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: Text(
                                          eventData['name'] ?? '',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                            color: Colors.deepPurple,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: PopupMenuButton<String>(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.deepPurple,
                                        ),
                                        onSelected: (value) {
                                          if (value == 'mapa') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MapPage(
                                                  targetAddress:
                                                      '${eventData['address'].split(',')[0].trim()} ${eventData['number']} ${eventData['address'].split(',')[1].trim()} ${eventData['address'].split(',')[2].trim()} ${eventData['address'].split(',')[3].trim()}',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          const PopupMenuItem<String>(
                                            value: 'mapa',
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.map,
                                                color: Colors.green,
                                              ),
                                              title: Text(
                                                'Mapa',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Informações:',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 4, 9, 0),
                                      width: 12,
                                      height: 11,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(130, 140, 255, 1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      'Data: ${formatDate(eventData['date'])}',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        letterSpacing: -0.2799999714,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 4, 9, 0),
                                      width: 12,
                                      height: 11,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(130, 140, 255, 1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      'Local: ${eventData['location']}',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        letterSpacing: -0.2799999714,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 4, 9, 0),
                                      width: 12,
                                      height: 11,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(130, 140, 255, 1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      'Descrição: ${eventData['description']}',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        letterSpacing: -0.2799999714,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      User? user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user == null) {
                                        // Se o usuário não estiver logado, redirecionar para a tela de login
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginPage()),
                                        );
                                        return;
                                      }

                                      // Gerar o código QR
                                      String qrData = user.uid; // Associar o QR code ao UID do usuário
                                      String qrCodeUrl =
                                          await generateQRCode(qrData);

                                      // Armazenar o QR code no Firebase
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.uid)
                                          .collection('qr_codes')
                                          .add({'url': qrCodeUrl});

                                      // Redirecionar para a página do QR code
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QRCodePage(
                                                  qrCodeUrl: qrCodeUrl,
                                                )),
                                      );
                                    },
                                    child: Text(
                                      'Comprar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
