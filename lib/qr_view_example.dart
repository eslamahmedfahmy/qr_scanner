import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("QR Scanner"),
        backgroundColor: Colors.teal.shade400,
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              cameraFacing: CameraFacing.back,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Colors.blue.shade200,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.teal.shade400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: (result != null)
                        ? Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                        : const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Scan Result : ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}