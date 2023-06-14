import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Client/events/client-homepage.dart';
import 'package:myapp/Client/events/my-events.dart';
import 'package:myapp/Client/profile/client-profile.dart';
import 'package:myapp/Client/utils/client-maps.dart';
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
  Future<String> _generateQRCodeUrl() async {
    User? user = FirebaseAuth.instance.currentUser;

    String qrData = '${user?.uid}-${widget.id}';

    final qrCode = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      // ignore: deprecated_member_use
      color: Colors.white,
      // ignore: deprecated_member_use
      emptyColor: const Color(0xFF4527A0),
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
        .doc(widget.id)
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
        var eventName = widget.storedocs[widget.indice]['name'];
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: const Color(0xFF4527A0),
          title: const Text(
            'E-vento',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(qrCodeUrl),
              const SizedBox(height: 14),
              const Text(
                'Aqui está o QR code para:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                ' $eventName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addEventToUser(String eventId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userRef.collection('comprados').doc(eventId).set({});
    }
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
          return const CircularProgressIndicator(color: Color(0xFF4527A0));
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
                  icon: const Icon(Icons.home, color: const Color(0xFF4527A0)),
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
                  icon: const Icon(Icons.map, color: const Color(0xFF4527A0)),
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
                  icon:
                      const Icon(Icons.person, color: const Color(0xFF4527A0)),
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
                  icon: const Icon(Icons.event, color: const Color(0xFF4527A0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyEvents()));
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
                                            fontFamily: 'Roboto',
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
                                      return const CircularProgressIndicator(
                                          color: Color(0xFF4527A0));
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
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      const Color(0xFF4527A0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  title: const Text(
                                                    'Confirmação',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  content: const Text(
                                                    'Você tem certeza que deseja comprar esse evento?',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                  actions: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            Colors.white,
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Cancelar',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        String qrData =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;
                                                        String qrCodeUrl =
                                                            await _generateQRCodeUrl();
                                                        await _addEventToUser(
                                                            widget.id);
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                ClientEventProfile(
                                                              id: widget.id,
                                                              indice:
                                                                  widget.indice,
                                                              storedocs: widget
                                                                  .storedocs,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Colors.white,
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Confirmar',
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFF4527A0),
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF4527A0),
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
                                                    'Roboto',
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
                                                          color: const Color(
                                                              0xFF4527A0),
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
