import 'dart:async'; // Importar Timer
import 'package:flutter/material.dart';
import 'package:app_test/screens/loading_screen.dart'; // Importar el widget de la pantalla de carga
import 'package:app_test/screens/home_screen.dart'; // Importar la clase HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: SplashScreen(), // Usar SplashScreen como la página inicial
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      // Navegar a la página principal después de 5 segundos
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()), // Usar HomeScreen como la página principal
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(); // Mostrar la pantalla de carga mientras se carga la aplicación
  }
}
