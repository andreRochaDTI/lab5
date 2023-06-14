import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  final String eventId;

  QRCodeScanner({required this.eventId});

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool showErrorMessage = false;
  Timer? timer;
  String? qrCodeContent;
  bool showValidMessage = false;

  @override
  void dispose() {
    controller?.dispose();
    timer?.cancel();
    super.dispose();
  }

  Future<void> validateQRCode(String code) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot<Object?> snapshot = await users.get();

    for (QueryDocumentSnapshot<Object?> document in snapshot.docs) {
      String userId = document.id;

      DocumentSnapshot<Object?> qrCodeSnapshot = await users
          .doc(userId)
          .collection('qr_codes')
          .doc(widget.eventId)
          .get();

      if (qrCodeSnapshot.exists && qrCodeSnapshot['qrCodeId'] == code) {
        setState(() {
          showMessageValid();
          qrCodeContent = code;
        });
        return;
      }
    }

    showMessageError();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!showValidMessage && scanData.code != null) {
        validateQRCode(scanData.code!);
      }
    });
  }

  void startTimer() {
    timer = Timer(const Duration(seconds: 15), () {
      setState(() {
        showErrorMessage = true;
      });
      pauseCamera();
    });
  }

  void pauseCamera() {
    controller?.pauseCamera();
    timer?.cancel();
  }

  void resumeCamera() {
    controller?.resumeCamera();
    startTimer();
  }

  void showMessageValid() {
    setState(() {
      showValidMessage = true;
    });

    pauseCamera();
  }

  void showMessageError() {
    setState(() {
      showErrorMessage = true;
    });

    pauseCamera();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: SquarePainter(),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height - 300) / 2 - 40,
            left: 0,
            right: 0,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Aponte para o QR Code para\n',
                    ),
                    TextSpan(
                      text: 'realizar a validação do ingresso',
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showErrorMessage)
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'QR Code inválido',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showErrorMessage = false;
                            });
                            resumeCamera();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 105,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[800],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ),
            ),
          if (showValidMessage)
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'QR Code válido.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Conteúdo do QR Code: $qrCodeContent',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showValidMessage = false;
                        });
                        resumeCamera();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 105,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Ler outro QR Code'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[800],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sair'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final squareRect = Rect.fromLTWH(
      (size.width - 200) / 2,
      (size.height - 200) / 2,
      200,
      200,
    );
    final squarePath = _getRoundedRectPath(squareRect, 20);
    canvas.drawPath(squarePath, paint);

    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    final overlayRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final overlayPath = Path.combine(
      PathOperation.difference,
      Path()..addRect(overlayRect),
      squarePath,
    );
    canvas.drawPath(overlayPath, overlayPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path _getRoundedRectPath(Rect rect, double radius) {
    final path = Path();
    path.moveTo(rect.left + radius, rect.top);
    path.lineTo(rect.right - radius, rect.top);
    path.arcToPoint(
      Offset(rect.right, rect.top + radius),
      radius: Radius.circular(radius),
    );
    path.lineTo(rect.right, rect.bottom - radius);
    path.arcToPoint(
      Offset(rect.right - radius, rect.bottom),
      radius: Radius.circular(radius),
    );
    path.lineTo(rect.left + radius, rect.bottom);
    path.arcToPoint(
      Offset(rect.left, rect.bottom - radius),
      radius: Radius.circular(radius),
    );
    path.lineTo(rect.left, rect.top + radius);
    path.arcToPoint(
      Offset(rect.left + radius, rect.top),
      radius: Radius.circular(radius),
    );
    return path;
  }
}
