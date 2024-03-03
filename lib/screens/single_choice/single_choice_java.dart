import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SCQuestionScreenJava(),
  ));
}

class Question {
  final String text;
  final List<String> options;
  final int correctOption;

  Question(this.text, this.options, this.correctOption);
}

class SCQuestionScreenJava extends StatefulWidget {
  const SCQuestionScreenJava({Key? key}) : super(key: key);

  @override
  _SCQuestionScreenStateJava createState() => _SCQuestionScreenStateJava();
}

class _SCQuestionScreenStateJava extends State<SCQuestionScreenJava> {
  int _currentQuestionIndex = 0;
  List<int?> selectedOptions = [];
  late Timer _timer;

  final List<Question> questions = [
    Question('¿Cuál de los siguientes no es un tipo de datos primitivo en Java?', ['int', 'string', 'boolean', 'double'], 1),
    Question('¿Qué tipo de lenguaje es Java?', ['Lenguaje de programación interpretado', 'Lenguaje de programación compilado', 'Lenguaje de marcado', 'Lenguaje de programación de scripting'], 1),
    Question('¿Cuál es el nombre del entorno de desarrollo integrado (IDE) más utilizado para Java?', ['Eclipse', 'Visual Studio Code', 'PyCharm', 'Sublime Text'], 0),
    Question('¿Qué significa JVM en Java?', ['Java Very Massive', 'Java Virtual Machine', 'Just Valid Markup', 'JavaScript Virtual Module'], 1),
    Question('¿Cuál es el punto de entrada de un programa Java?', ['start()', 'main()', 'run()', 'execute()'], 1)
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
