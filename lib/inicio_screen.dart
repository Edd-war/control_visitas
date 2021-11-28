import 'package:control_visitas/formulario_screen.dart';
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Fondo.jpeg'), fit: BoxFit.fill))),
        const Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 550),
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Bienvenido Colono !!",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Positioned(
          child: cargando == true ? const CircularProgressIndicator() : Container(),
          top: 350,
        ),
        Card(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 300),
          color: Colors.transparent,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey[400], 
              elevation: 350.0),
              onPressed: () {
                cargando = true;
                setState(() {});
                Future.delayed(const Duration(seconds: 5),(){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const FormularioScreen())
                    );
                });
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.login), 
                    Text("Registrar Nueva Visita"),
                  ]
              )
          ),
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 250),
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
                    MaterialPageRoute(builder: (context) => Scanner())
                    );
                });
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.login), 
                    Text("Escanear Código QR"),
                  ]
              )
          ),
        )
      ],
    );
  }
}
