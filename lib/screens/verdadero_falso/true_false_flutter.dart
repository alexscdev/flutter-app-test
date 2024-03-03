import 'dart:async';
import 'package:flutter/material.dart';

class VFQuestionScreenFlutter extends StatefulWidget {
  const VFQuestionScreenFlutter({Key? key}) : super(key: key);

  @override
  _VFQuestionScreenStateFlutter createState() => _VFQuestionScreenStateFlutter();
}

class _VFQuestionScreenStateFlutter extends State<VFQuestionScreenFlutter> {
  int _currentQuestionIndex = 0;
  List<String?> selectedOptions = [];
  late Timer _timer;

  // Lista de preguntas con sus respuestas correctas
  final List<Map<String, dynamic>> questions = [
    {'question': 'Flutter es un framework desarrollado por Google?', 'correctAnswer': 'Verdadero'},
    {'question': 'Flutter se utiliza principalmente para el desarrollo de aplicaciones web?', 'correctAnswer': 'Falso'},
    {'question': 'Flutter utiliza el lenguaje de programación Dart?', 'correctAnswer': 'Verdadero'},
    {'question': 'Flutter permite el desarrollo de aplicaciones multiplataforma?', 'correctAnswer': 'Verdadero'},
    {'question': 'Flutter es una herramienta para el desarrollo de aplicaciones móviles nativas?', 'correctAnswer': 'Verdadero'},
  ];

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
        if (selectedOptions.isEmpty) {
          _showResults();
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

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResults();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _showResults() {
    int correctAnswers = 0;
    int incorrectAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final selected = selectedOptions.length > i ? selectedOptions[i] : null;
      final correctAnswer = question['correctAnswer'];
      if (selected == correctAnswer) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Respuestas correctas: $correctAnswers'),
              Text('Respuestas incorrectas: $incorrectAnswers'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
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
            const SizedBox(height: 20),
            Text(
              questions[_currentQuestionIndex]['question'] as String,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // ListView para mostrar las opciones
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                final option = index == 0 ? 'Verdadero' : 'Falso';
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: selectedOptions.length > _currentQuestionIndex ? selectedOptions[_currentQuestionIndex] : null,
                  onChanged: (value) {
                    setState(() {
                      selectedOptions.length <= _currentQuestionIndex ? selectedOptions.add(value) : selectedOptions[_currentQuestionIndex] = value;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _previousQuestion,
                  child: const Text('Anterior'),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: _currentQuestionIndex < questions.length - 1 ? const Text('Siguiente') : const Text('Terminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
