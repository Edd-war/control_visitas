import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

import 'models/visitas_dao.dart';

class QRResults extends StatelessWidget {
  final VisitaDAO visitaDAO;
  final String intencion;

  const QRResults({Key? key, required this.visitaDAO, required this.intencion})
      : super(key: key);

  Future<String> generarQR(String qr) async {
    String path = '';
    final validacionQR = QrValidator.validate(
        data: qr,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L
    );
    if (validacionQR.status == QrValidationStatus.valid) {
      final qrCode = validacionQR.qrCode;
      Directory? tempDir = await getExternalStorageDirectory();
      String tempPath = tempDir!.path;
      final timeStamp = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      path = '$tempPath/$timeStamp.png';

      final picData = await QrPainter.withQr(
          qr: qrCode!,
          color: Colors.black,
          emptyColor: Colors.white,
          gapless: true,
          embeddedImageStyle: null,
          embeddedImage: null
      ).toImageData(1080, format: ImageByteFormat.png);
      await digitalizarQR(picData!, path);
      return path;
    } else {
      return validacionQR.error.toString();
      // print(validacionQR.error);
    }
  }

  Future<void> digitalizarQR(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog showDialogVisitaGenerada(BuildContext context, VisitaDAO visita) {
      return AlertDialog(
        title: const Text('Código QR'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Comparte este código QR a tu visita',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              const SizedBox(height: 15.0),
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: QrImage(
                    data: visitaDAO.toJson(),
                    size: 200,
                    backgroundColor: Colors.white,
                    errorStateBuilder: (context, error) =>
                        Text(error.toString())
                ),
              ),
              TextButton(
                child: const Text('Guardar'),
                onPressed: () async {
                  // String path = await generarQR(_visitaDAO.toMap().toString());
                  // final QRguardado = await GallerySaver.saveImage(path);
                  // Scaffold.of(context).showSnackBar(SnackBar(
                  //   content: QRguardado! ? const Text('Image saved to Gallery') : const Text('Error saving image'),
                  // ));
                },
              ),
              TextButton(
                child: const Text('Compartir'),
                onPressed: () async {
                  String path = await generarQR(visitaDAO.toJson());
                  await Share.shareFiles(
                      [path],
                      mimeTypes: ["image/png"],
                      subject: 'Mi visita en QR',
                      text: 'Muéstrame en la entrada con el vigilante'
                  );
                },
              ),
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    }

    AlertDialog showDialogVisitaNoGenerada(BuildContext context, VisitaDAO visita) {
      return AlertDialog(
        title: const Text('Código QR'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Comparte este código QR a tu visita',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              const SizedBox(height: 15.0),
              SizedBox(
                width: 200.0,
                height: 200.0,
                child: QrImage(
                    data: visitaDAO.toJson(),
                    size: 200,
                    backgroundColor: Colors.white,
                    errorStateBuilder: (context, error) =>
                        Text(error.toString())
                ),
              ),
              TextButton(
                child: const Text('Guardar'),
                onPressed: () async {
                  // String path = await generarQR(_visitaDAO.toMap().toString());
                  // final QRguardado = await GallerySaver.saveImage(path);
                  // Scaffold.of(context).showSnackBar(SnackBar(
                  //   content: QRguardado! ? const Text('Image saved to Gallery') : const Text('Error saving image'),
                  // ));
                },
              ),
              TextButton(
                child: const Text('Compartir'),
                onPressed: () async {
                  String path = await generarQR(visitaDAO.toJson());
                  await Share.shareFiles(
                      [path],
                      mimeTypes: ["image/png"],
                      subject: 'Mi visita en QR',
                      text: 'Muéstrame en la entrada con el vigilante'
                  );
                },
              ),
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    }

    AlertDialog showDialogVisitaAutorizada(BuildContext context, VisitaDAO visita) {
      SizedBox separador = const SizedBox(height: 10);
      return AlertDialog(
        title: const Text('Visita Esperada'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Nombre: " + visita.visitanteTitular!),
            separador,
            Text("Nombre: " + visita.numeroPersonas!.toString()),
            separador,
            Text("Nombre: " + visita.calle!),
            separador,
            Text("Nombre: " + visita.numero!),
            separador,
            Text("Nombre: " + visita.fecha!),
            separador,
            Text("Nombre: " + visita.formaLlegada!),
            separador,
            Text("Nombre: " + visita.status!.toString()),
            separador,
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Autorizar Pase'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }

    AlertDialog showDialogVisitaNoAutorizada(BuildContext context, VisitaDAO visita) {
      SizedBox separador = const SizedBox(height: 10);
      return AlertDialog(
        title: const Text('Visita Esperada'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Nombre: " + visita.visitanteTitular!),
            separador,
            Text("Nombre: " + visita.numeroPersonas!.toString()),
            separador,
            Text("Nombre: " + visita.calle!),
            separador,
            Text("Nombre: " + visita.numero!),
            separador,
            Text("Nombre: " + visita.fecha!),
            separador,
            Text("Nombre: " + visita.formaLlegada!),
            separador,
            Text("Nombre: " + visita.status!.toString()),
            separador,
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Autorizar Pase'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }

    switch (intencion) {
      case "generar":
        switch (visitaDAO
            .visitanteTitular) { //Cambiar condición por el identificador de la visita
          case null:
            return showDialogVisitaNoGenerada(context, visitaDAO);
          default:
            return showDialogVisitaGenerada(context, visitaDAO);
        }
      case "escanear":
        switch (visitaDAO.status) {
          case null:
            return showDialogVisitaNoAutorizada(context, visitaDAO);
          case 0:
            return showDialogVisitaAutorizada(context, visitaDAO);
          default:
            return showDialogVisitaNoAutorizada(context, visitaDAO);
        }

      default:
        print("ERROR EN LA INTENCION: NO INTENCIÓN = NO ACCION, NO RESULTADO");
        // return showDialogVisitaNoGenerada(context, visitaDAO);
        return showDialogVisitaAutorizada(context, visitaDAO);
    }
  }
}
