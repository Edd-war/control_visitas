import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:control_visitas/models/visitas_dao.dart';
import 'package:control_visitas/providers/firebase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({Key? key}) : super(key: key);

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  DateTime? _dateEntrega;
  String? _verFecha;
  late FirebaseProvider _provider;
  late VisitaDAO _visitaDAO;
  final key = GlobalKey();
  File? file;
  //controladores
  TextEditingController controller_nombreTitular = TextEditingController();
  TextEditingController controller_numeroVisitantes = TextEditingController();
  TextEditingController controller_calle = TextEditingController();
  TextEditingController controller_numero = TextEditingController();
  TextEditingController controller_formaLlegada = TextEditingController();
  QrImage? _qrImage;

  showQR() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Código QR'),
              content: Center(
                child: _qrImage = QrImage(
                  data: _visitaDAO.toMap().toString(),
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Guardar'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text('Compartir'),
                  onPressed: () {},
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  insert() {
    try {
      _provider.saveVisita(_visitaDAO); //guardamos en DB
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos guardados correctamente')));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al guardar los datos')));
    }
  }

  @override
  void initState() {
    super.initState();
    _provider = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programar Nueva Visita'),
        backgroundColor: Colors.blueGrey.shade500,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextFormField(
                controller: controller_nombreTitular,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'Ingresa tu nombre',
                    labelText: 'Nombre(s) *',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: controller_numeroVisitantes,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.group),
                    hintText: 'Número de visitantes',
                    labelText: 'Número de visitantes *',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: controller_calle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.location_city),
                    hintText: 'Calle del colono',
                    labelText: 'Calle del colono',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: controller_numero,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.format_list_numbered_rtl),
                    hintText: 'Número de la Casa',
                    labelText: 'Número de la Casa*',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: controller_formaLlegada,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    icon: Icon(Icons.car_rental),
                    hintText: 'Forma de llegada del visitante',
                    labelText: 'Forma de llegada del Visitante*',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: _dateEntrega == null
                              ? DateTime.now()
                              : _dateEntrega!,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025))
                      .then((date) {
                    _verFecha = '${date!.year}/${date.month}/${date.day}';
                    //print(_verFecha);
                    _dateEntrega = date;
                    setState(() {});
                  });
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                      icon: Icon(Icons.date_range),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabled: true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _verFecha == null ? 'Seleccionar fecha' : _verFecha!,
                      ),
                      Icon(Icons.arrow_drop_down,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey.shade700
                                  : Colors.white70),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade400,
                ),
                onPressed: () {
                  //falta validar que no esten vacios
                  _visitaDAO = VisitaDAO(
                      visitanteTitular: controller_nombreTitular.text,
                      numeroPersonas:
                          int.parse(controller_numeroVisitantes.text),
                      calle: controller_calle.text,
                      numero: controller_numero.text,
                      fecha: _verFecha,
                      formaLlegada: controller_formaLlegada.text,
                      status: 0);
                  //insert();
                  showQR();
                  controller_nombreTitular.clear();
                  controller_numeroVisitantes.clear();
                  controller_calle.clear();
                  controller_numero.clear();
                  controller_formaLlegada.clear();
                  setState(() {
                    _verFecha = 'Seleccionar fecha';
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Programar Visita',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
