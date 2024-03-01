import 'package:app_llankay/vistas/login.dart';
import 'package:app_llankay/vistas/offerJob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Image(
                  width: 200,
                  height: 200,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
              Text("Perfil"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Inicio'), // Título
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color.fromARGB(255, 224, 169, 3),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 4, 62, 109),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(20),
                child: Image(
                  // Especifica un tamaño si es necesario
                  width: 300,
                  height: 300,
                  image: AssetImage(
                      'assets/logo.png'), // Cambiado de Image.asset a AssetImage
                  // Ajusta el comportamiento de la imagen según tus necesidades
                  fit: BoxFit.contain,
                )),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                'Bienvenido, selecciona que actividad deseas hacer:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Offer()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 4, 62, 109),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'OFERTAR TRABAJO',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 4, 62, 109),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'BUSCAR TRABAJO',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
