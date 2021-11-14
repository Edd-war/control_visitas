import 'package:control_visitas/FormularioScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var cargando = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Fondo.jpeg'), fit: BoxFit.fill))),
        Container(
          child: Card(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 550),
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bienvenido Colono !!",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          child: cargando == true ? CircularProgressIndicator() : Container(),
          top: 350,
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 300),
          color: Colors.transparent,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey[400], 
              elevation: 350.0),
              onPressed: () {
                cargando = true;
                setState(() {});
                Future.delayed(Duration(seconds: 5),(){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => FormularioScreen())
                    );
                });
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.login), 
                    Text("Registrar Nueva Visita"),
                  ]
              )
          ),
        )
      ],
    );
  }
}
