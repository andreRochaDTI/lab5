import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Client/events/client-homepage.dart';
import 'package:myapp/Client/profile/client-profile.dart';
import 'package:myapp/Client/utils/maps.dart';
import 'dart:ui' as ui;
import 'package:qr_flutter/qr_flutter.dart';
import '../../utils/utils.dart';

class ClientEventProfile extends StatefulWidget {
  final String id;
  final int indice;
  final List storedocs;

  const ClientEventProfile(
      {required this.id, required this.indice, required this.storedocs});

  @override
  _ClientEventProfileState createState() => _ClientEventProfileState();
}

class _ClientEventProfileState extends State<ClientEventProfile> {
  late Future<String> _qrCodeUrlFuture;

  Future<String> _generateQRCodeUrl() async {
    User? user = FirebaseAuth.instance.currentUser;

    String qrData = '${user?.uid}-${widget.id}';

    final qrCode = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      color: const Color(0xff000000),
      emptyColor: const Color(0xffffffff),
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    const qrCodeSize = 200.0;
    final imageSize = (qrCodeSize * ui.window.devicePixelRatio).round();
    final image = await qrCode.toImageData(imageSize.toDouble());

    final storageRef =
        FirebaseStorage.instance.ref().child('qr_codes/$qrData.png');
    await storageRef.putData(image!.buffer.asUint8List());
    final qrCodeUrl = await storageRef.getDownloadURL();

    String eventName = widget.storedocs[widget.indice]['name'];

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('qr_codes')
        .doc(eventName)
        .set({
      'url': qrCodeUrl,
      'eventId': widget.id,
      'eventName': eventName,
      'qrCodeId': qrData
    });

    return qrCodeUrl;
  }

  Future<void> _showQRCodeDialog(String qrCodeUrl) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(qrCodeUrl),
              const SizedBox(height: 8),
              const Text('Aqui está o seu QR code!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');
    DocumentReference eventRef = events.doc(widget.id);

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
          body: Stack(
            children: [
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
                                          style: const TextStyle(
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
                                                builder: (context) =>
                                                    ClientMapPage(
                                                  targetAddress:
                                                      '${eventData['address'].split(',')[0].trim()} ${eventData['addressNumber']} ${eventData['address'].split(',')[1].trim()} ${eventData['address'].split(',')[2].trim()} ${eventData['address'].split(',')[3].trim()}',
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
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                    letterSpacing: -0.4099999964,
                                    color: Colors.deepPurple,
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
                                        'Montserrat',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      eventData['date'] ?? '',
                                      style: SafeGoogleFont(
                                        'Montserrat',
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
                                          'Montserrat',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          height: 1.5,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Positioned(
                                      child: Text(
                                        eventData['time'] ?? '',
                                        style: SafeGoogleFont(
                                          'Montserrat',
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
                                            'Montserrat',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                            letterSpacing: -0.408,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${eventData['address'].split(',')[0].trim()} ${eventData['addressNumber']} ${eventData['address'].split(',')[1].trim()} ${eventData['address'].split(',')[2].trim()} ${eventData['address'].split(',')[3].trim()}',
                                      style: SafeGoogleFont(
                                        'Montserrat',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        color: const Color(0xff05be77),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('qr_codes')
                                      .where('eventId', isEqualTo: widget.id)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return const Text(
                                          'Erro ao buscar os dados.');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            String qrData = FirebaseAuth
                                                .instance.currentUser!.uid;
                                            String qrCodeUrl =
                                                await _generateQRCodeUrl();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.deepPurple,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text(
                                            'Comprar',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      String qrCodeUrl =
                                          snapshot.data!.docs[0].get('url');
                                      return SizedBox(
                                        child: Column(
                                          children: [
                                            Align(
                                              child: SizedBox(
                                                width: 273,
                                                height: 20,
                                                child: Text(
                                                  'O QR Code lido perderá o valor após ser validado.',
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont(
                                                    'Montserrat',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5,
                                                    letterSpacing:
                                                        -0.4099999964,
                                                    color:
                                                        const Color(0xffa88686),
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
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            _showQRCodeDialog(
                                                                qrCodeUrl);
                                                          },
                                                          icon: const Icon(
                                                              Icons.qr_code),
                                                          iconSize: 60.0,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        const SizedBox(
                                                            height: 2.0),
                                                        const Text(
                                                          'Gerar QR code.',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors
                                                                .deepPurple,
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
                                      );
                                    }
                                  },
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
            ],
          ),
        );
      },
    );
  }
}
