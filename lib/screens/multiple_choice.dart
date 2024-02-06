import 'dart:async';
import 'package:flutter/material.dart';

class MCQuestionScreen extends StatefulWidget {
  const MCQuestionScreen({Key? key}) : super(key: key);

  @override
  _MCQuestionScreenState createState() => _MCQuestionScreenState();
}

class _MCQuestionScreenState extends State<MCQuestionScreen> {
  List<String> selectedOptions = [];
  late Timer _timer;

  // Lista de opciones para la pregunta
  final List<String> options = [
    'Madrid',
    'Londres',
    'París',
    'Berlín',
  ];

  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador de 30 segundos al cargar la página
    _startTimer();
  }

  @override
  void dispose() {
    // Detener el temporizador al salir de la página
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick >= 30) {
        timer.cancel();
        if (selectedOptions.isEmpty) {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {}); // Actualiza el estado para redibujar el temporizador
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta de Test'),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              '${30 - _timer.tick} segundos',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Cuál es la capital de Francia?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // ListView para mostrar las opciones
            ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return CheckboxListTile(
                  title: Text(option),
                  value: selectedOptions.contains(option),
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked != null && isChecked) {
                        selectedOptions.add(option);
                      } else {
                        selectedOptions.remove(option);
                      }
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para manejar las opciones seleccionadas
                if (selectedOptions.isNotEmpty) {
                  print('Opciones seleccionadas: $selectedOptions');
                  // Aquí puedes agregar lógica adicional para manejar las opciones seleccionadas
                } else {
                  print('No se ha seleccionado ninguna opción.');
                }
              },
              child: const Text('Enviar respuesta'),
            ),
          ],
        ),
      ),
    );
  }
}
