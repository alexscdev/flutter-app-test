import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SCQuestionScreenFlutter(),
  ));
}

class Question {
  final String text;
  final List<String> options;
  final int correctOption;

  Question(this.text, this.options, this.correctOption);
}

class SCQuestionScreenFlutter extends StatefulWidget {
  const SCQuestionScreenFlutter({Key? key}) : super(key: key);

  @override
  _SCQuestionScreenStateFlutter createState() => _SCQuestionScreenStateFlutter();
}

class _SCQuestionScreenStateFlutter extends State<SCQuestionScreenFlutter> {
  int _currentQuestionIndex = 0;
  List<int?> selectedOptions = [];
  late Timer _timer;

  final List<Question> questions = [
    Question('¿Cuál es el lenguaje de programación principal utilizado en Flutter?', ['Java', 'Dart', 'Python', 'C++'], 1),
    Question('¿Quién desarrolló Flutter?', ['Microsoft', 'Apple', 'Google', 'Facebook'], 2),
    Question('¿Flutter es un framework para qué tipo de desarrollo?', ['Desarrollo web', 'Desarrollo móvil', 'Inteligencia artificial', 'Desarrollo de videojuegos'], 1),
    Question('¿Qué plataforma móvil es compatible con Flutter?', ['iOS', 'Windows Mobile', 'Blackberry OS', 'Symbian'], 0),
    Question('¿Qué tecnología se utiliza para la creación de interfaces de usuario en Flutter?', ['HTML', 'CSS', 'XML', 'Widgets'], 3)
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (int i = 0; i < questions.length; i++) {
      selectedOptions.add(null);
    }
  }



  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick >= 30) {
        timer.cancel();
        if (selectedOptions.any((element) => element == null)) {
          _showResults(); // Mostrar resultados si no se ha respondido ninguna pregunta
        }
      } else {
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      if (selectedOptions[_currentQuestionIndex] != null) {
        _showResults();
      }
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
      final selectedOption = selectedOptions[i];

      if (selectedOption == question.correctOption) {
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
              questions[_currentQuestionIndex].text,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: questions[_currentQuestionIndex].options.length,
              itemBuilder: (context, index) {
                final option = questions[_currentQuestionIndex].options[index];
                return RadioListTile<int?>(
                  title: Text(option),
                  value: index,
                  groupValue: selectedOptions[_currentQuestionIndex],
                  onChanged: (value) {
                    setState(() {
                      selectedOptions[_currentQuestionIndex] = value;
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
