import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;

import 'models/visitas_dao.dart';


class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  _Scanner createState() => _Scanner();
}

class _Scanner extends State<Scanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  late VisitaDAO _visita;
  Barcode? _barcode;

  @override
  void dispose() {
    qrViewController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if(Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom: 10, child: buildResult()),
          Positioned(top: 10, child: buildControlButtons())
        ],
      ),
    )
  );

  Widget buildControlButtons() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: FutureBuilder<bool?>(
            future: qrViewController?.getFlashStatus(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
              } else {
                return Container();
              }
            }
          ),
          onPressed: () async {
            await qrViewController?.toggleFlash();
            setState(() {});
        },
        ),
        IconButton(
          icon: FutureBuilder(
            future: qrViewController?.getCameraInfo(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return const Icon(Icons.switch_camera);
              } else {
                return Container();
              }
            }
          ),
          onPressed: () async {
            await qrViewController?.flipCamera();
            setState(() {});
          }
        ),
      ],
    ),
  );

  Widget buildResult() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Text(
      _barcode != null ? "Resultado: ${_barcode!.code}" : "Escanea un código",
    )
  );

  Widget buildQrView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).accentColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      )
  );

  void onQRViewCreated(QRViewController controller){
    setState(() => qrViewController = controller);
    controller.scannedDataStream.listen((barcode) =>
      setState(() => _barcode = barcode));
    }
}

  // void onQRViewCreated(QRViewController controller) {
//   setState(() => qrViewController = controller);
  //   controller.scannedDataStream.listen((barcode) {
  //     setState(() {
  //       _barcode = barcode;
  //       try {
  //         _visita = VisitaDAO.fromJson(_barcode!.code!);
  //       } catch(e) {
  //         _visita = VisitaDAO(); //OBJETO VISITANTE NULO
  //         print("EL QR INGRESADO NO ES UN VISITANTE ");
  //         // QRResults(visitaDAO: visita, intencion: "escanear");
  //       }
  //       print(barcode.code);
  //     });
  //   });
  // }

  // void pauseQRView() async {
  //   await qrViewController?.pauseCamera();
  // }

