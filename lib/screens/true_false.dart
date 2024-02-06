import 'dart:async';
import 'package:flutter/material.dart';

class VFQuestionScreen extends StatefulWidget {
  const VFQuestionScreen({Key? key}) : super(key: key);

  @override
  _VFQuestionScreenState createState() => _VFQuestionScreenState();
}

class _VFQuestionScreenState extends State<VFQuestionScreen> {
  String? selectedOption;
  late Timer _timer;

  // Lista de opciones para la pregunta
  final List<String> options = ['Verdadero', 'Falso'];

  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador de 30 segundos al cargar la página
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick >= 30) {
        timer.cancel();
        if (selectedOption == null) {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {}); // Actualiza el estado para redibujar el temporizador
      }
    });
  }

  @override
  void dispose() {
    // Detener el temporizador al salir de la página
    _timer.cancel();
    super.dispose();
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
              '¿Es París la capital de Francia?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // ListView para mostrar las opciones
            ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para manejar la opción seleccionada
                if (selectedOption != null) {
                  print('Opción seleccionada: $selectedOption');
                  // Aquí puedes agregar lógica adicional para manejar la opción seleccionada
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
