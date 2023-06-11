import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {
  final String qrCodeUrl;

  const QRCodePage({required this.qrCodeUrl});

  @override
  Widget build(BuildContext context) {
    final qrCodeSize = 200.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(child: Container()),
    );
  }
}
