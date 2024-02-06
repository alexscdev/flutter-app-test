import 'dart:async'; // Importar Timer
import 'package:flutter/material.dart';

class SCQuestionScreen extends StatefulWidget {
  const SCQuestionScreen({Key? key}) : super(key: key);

  @override
  _SCQuestionScreenState createState() => _SCQuestionScreenState();
}

class _SCQuestionScreenState extends State<SCQuestionScreen> {
  String? selectedOption;
  late Timer _timer;
  late DateTime _startTime;
  final int _timerDurationInSeconds = 30;

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
    // Iniciar el temporizador al cargar la página
    _startTimer();
  }

  @override
  void dispose() {
    // Detener el temporizador al salir de la página
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {}); // Actualizar el estado para que se vuelva a construir el temporizador
      if (DateTime.now().difference(_startTime).inSeconds >= _timerDurationInSeconds) {
        _timer.cancel();
        if (selectedOption == null) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcular el tiempo restante
    int remainingTimeInSeconds = _timerDurationInSeconds - DateTime.now().difference(_startTime).inSeconds;
    if (remainingTimeInSeconds < 0) {
      remainingTimeInSeconds = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta de Test'),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              '$remainingTimeInSeconds segundos',
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
