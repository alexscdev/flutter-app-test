import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MCQuestionScreenOdoo(),
  ));
}

class Question {
  final String text;
  final List<String> options;
  final int correctOption;

  Question(this.text, this.options, this.correctOption);
}

class MCQuestionScreenOdoo extends StatefulWidget {
  const MCQuestionScreenOdoo({Key? key}) : super(key: key);

  @override
  _MCQuestionScreenStateOdoo createState() => _MCQuestionScreenStateOdoo();
}

class _MCQuestionScreenStateOdoo extends State<MCQuestionScreenOdoo> {
  int _currentQuestionIndex = 0;
  List<List<String>> selectedOptions = [];
  late Timer _timer;

  final List<Question> questions = [
    Question('¿Cuál de las siguientes opciones describe mejor a Odoo?', ['Plataforma de redes sociales', 'Sistema operativo', 'Sistema de gestión empresarial', 'Lenguaje de programación'], 2),
    Question('¿Qué lenguaje de programación se utiliza principalmente en el desarrollo de Odoo?', ['Java', 'Python', 'C#', 'Ruby'], 1),
    Question('¿Qué tipo de software es Odoo?', ['Software propietario', 'Software de código cerrado', 'Software de código abierto', 'Software comercial'], 2),
    Question('¿Cuál es el nombre anterior de Odoo?', ['OpenERP', 'Microsoft Dynamics', 'SAP', 'Salesforce'], 0),
    Question('¿Qué área de una empresa puede gestionarse utilizando Odoo?', ['Solo recursos humanos', 'Solo contabilidad', 'Ventas, inventario y contabilidad', 'Solo marketing'], 2)
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
          _showResults();
        }
      } else {
        setState(() {}); // Actualiza el estado para redibujar el temporizador
      }
    });
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
      final selected = selectedOptions.length > i ? selectedOptions[i] : [];
      final correctOption = question.correctOption;
      if (selected.length == 1 && selected.contains(question.options[correctOption])) {
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
            // ListView para mostrar las opciones
            ListView.builder(
              shrinkWrap: true,
              itemCount: questions[_currentQuestionIndex].options.length,
              itemBuilder: (context, index) {
                final option = questions[_currentQuestionIndex].options[index];
                return CheckboxListTile(
                  title: Text(option),
                  value: selectedOptions.length > _currentQuestionIndex && selectedOptions[_currentQuestionIndex].contains(option),
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked != null && isChecked) {
                        if (selectedOptions.length <= _currentQuestionIndex) {
                          selectedOptions.add([]);
                        }
                        selectedOptions[_currentQuestionIndex].add(option);
                      } else {
                        selectedOptions[_currentQuestionIndex].remove(option);
                      }
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
