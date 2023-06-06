import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanStarted = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Aqui você pode tratar o resultado do scan, por exemplo, exibindo o valor lido
      print('QR Code lido: ${scanData.code}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (scanStarted) {
                      controller?.resumeCamera();
                    } else {
                      controller?.pauseCamera();
                    }
                    setState(() {
                      scanStarted = !scanStarted;
                    });
                  },
                  child: Text(scanStarted ? 'Pausar' : 'Iniciar'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
