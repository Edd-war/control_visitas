import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({Key? key}) : super(key: key);

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  DateTime? _dateEntrega;

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
                      Text('Fecha de la Visita'),
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
                onPressed: () {},
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
