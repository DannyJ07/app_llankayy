import 'package:app_llankay/home.dart';
import 'package:app_llankay/vistas/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Llankay",
      home: Login(),
    );
  }
}
