import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  // Lista de textos aleatorios
  static final List<String> randomTexts = [
    "Cargando...",
    "Espere un momento...",
    "Preparando...",
  ];

  // Lista de imágenes aleatorias (puedes usar AssetImage para imágenes locales)
  static final List<String> randomImages = [
    "https://via.placeholder.com/150", // Ejemplo de URL de imagen aleatoria
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
  ];

  // Texto y imagen aleatorios seleccionados una vez en la creación del widget
  final String randomText;
  final String randomImage;

  // Constructor que selecciona un texto y una imagen aleatorios una vez
  LoadingScreen()
      : randomText = randomTexts[Random().nextInt(randomTexts.length)],
        randomImage = randomImages[Random().nextInt(randomImages.length)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostrar el texto aleatorio
            Text(
              randomText,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Mostrar la imagen aleatoria
            Image.network(
              randomImage,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Indicador de progreso
          ],
        ),
      ),
    );
  }
}

