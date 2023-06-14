import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Admin/events/admin-homepage.dart';
import 'package:myapp/Admin/events/qr-reader.dart';
import 'package:myapp/Admin/events/update-event-list.dart';
import 'package:myapp/Admin/profile/profile.dart';

import '../utils/admin-maps.dart';
import '../../utils/utils.dart';

class AdminEventProfile extends StatelessWidget {
  final String id;
  final int indice;
  final List storedocs;

  const AdminEventProfile(
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
            return const CircularProgressIndicator(color: Color(0xFF4527A0));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Evento não encontrado.');
          }

          Map<String, dynamic> eventData =
              snapshot.data!.data() as Map<String, dynamic>;

          CollectionReference events =
              FirebaseFirestore.instance.collection('events');
          Future<void> deleteEvent(id) {
            return events
                .doc(id)
                .delete()
                .then((value) {})
                .catchError((error) {});
          }

          Map<String, dynamic>? deletedEvent;

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
                                          style: SafeGoogleFont(
                                            'Roboto',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                            color: const Color(0xFF4527A0),
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: PopupMenuButton<String>(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: const Color(0xFF4527A0),
                                        ),
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateEvent(
                                                  id: storedocs[indice]['id'],
                                                ),
                                              ),
                                            );
                                          } else if (value == 'delete') {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFF4527A0),
                                                  title: const Text(
                                                    'Deletar evento',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Tem certeza que deseja deletar este evento?',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Cancelar',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Deletar',
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFF4527A0),
                                                          fontSize: 20,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        deletedEvent =
                                                            storedocs[indice];
                                                        deleteEvent(
                                                            storedocs[indice]
                                                                ['id']);
                                                        storedocs
                                                            .removeAt(indice);
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminHomePage(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else if (value == 'mapa') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminMapPage(
                                                  targetAddress:
                                                      '${eventData['address'].split(',')[0].trim()} ${eventData['addressNumber']} ${eventData['address'].split(',')[1].trim()} ${eventData['address'].split(',')[2].trim()} ${eventData['address'].split(',')[3].trim()}',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          const PopupMenuItem<String>(
                                            value: 'edit',
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.edit,
                                                color: const Color(0xFF4527A0),
                                              ),
                                              title: Text(
                                                'Editar',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF4527A0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              title: Text(
                                                'Deletar',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
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
                                  style: SafeGoogleFont(
                                    'Roboto',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                    letterSpacing: -0.4099999964,
                                    color: const Color(0xFF4527A0),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 4, 9, 0),
                                      width: 12,
                                      height: 11,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffc4c4c4),
                                      ),
                                    ),
                                    Text(
                                      'Data:',
                                      style: SafeGoogleFont(
                                        'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                        color: const Color(0xFF4527A0),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      eventData['date'] ?? '',
                                      style: SafeGoogleFont(
                                        'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        color: const Color(0xff05be77),
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
                                        color: Color(0xffc4c4c4),
                                      ),
                                    ),
                                    Positioned(
                                      child: Text(
                                        'Hora: ',
                                        style: SafeGoogleFont(
                                          'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          height: 1.5,
                                          color: const Color(0xFF4527A0),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Positioned(
                                      child: Text(
                                        eventData['time'] ?? '',
                                        style: SafeGoogleFont(
                                          'Roboto',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                          color: const Color(0xff05be77),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 4, 9, 0),
                                          width: 12,
                                          height: 11,
                                          decoration: const BoxDecoration(
                                            color: Color(0xffc4c4c4),
                                          ),
                                        ),
                                        Text(
                                          'Endereço: ',
                                          style: SafeGoogleFont(
                                            'Roboto',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                            letterSpacing: -0.408,
                                            color: const Color(0xFF4527A0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${eventData['address'].split(',')[0].trim()} ${eventData['addressNumber']} ${eventData['address'].split(',')[1].trim()} ${eventData['address'].split(',')[2].trim()} ${eventData['address'].split(',')[3].trim()}',
                                      style: SafeGoogleFont(
                                        'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        color: const Color(0xff05be77),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 60),
                                        child: Text(
                                          'Situação do evento:',
                                          style: SafeGoogleFont(
                                            'Roboto',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            height: 1,
                                            color: const Color(0xFF4527A0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Disponível',
                                      style: SafeGoogleFont(
                                        'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        height: 1,
                                        letterSpacing: -0.4099999964,
                                        color: const Color(0xff05be77),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Positioned(
                                  child: Align(
                                    child: SizedBox(
                                      width: 273,
                                      height: 20,
                                      child: Text(
                                        'O QR Code lido perderá o valor após ser validado.',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Roboto',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          letterSpacing: -0.4099999964,
                                          color: const Color(0xffa88686),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QRCodeScanner(
                                                              eventId: storedocs[
                                                                      indice]
                                                                  ['id'])),
                                                );
                                              },
                                              icon: const Icon(Icons.qr_code),
                                              iconSize: 60.0,
                                              color: const Color(0xFF4527A0),
                                            ),
                                            const SizedBox(height: 2.0),
                                            const Text(
                                              'Ler QR code.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF4527A0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.home, color: const Color(0xFF4527A0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminHomePage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.map, color: const Color(0xFF4527A0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminMapPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person,
                        color: const Color(0xFF4527A0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
