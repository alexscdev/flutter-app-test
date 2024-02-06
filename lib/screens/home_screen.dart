import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'single_choice.dart'; // Importa tus clases de preguntas aquí
import 'multiple_choice.dart';
import 'true_false.dart';

class HomeScreen extends StatelessWidget {
  final List<String> themes = ['Odoo', 'Flutter'];
  String? selectedTheme;
  int? numberOfQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu),
            onSelected: (String value) {
              // Handle menu item selection
              switch (value) {
                case 'SC':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SCQuestionScreen()));
                  break;
                case 'MC':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MCQuestionScreen()));
                  break;
                case 'VF':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VFQuestionScreen()));
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return ['SC', 'MC', 'VF'].map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select a theme:'),
            DropdownButton<String>(
              value: selectedTheme,
              onChanged: (String? newValue) {
                selectedTheme = newValue;
              },
              items: themes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Enter the number of questions:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                numberOfQuestions = int.tryParse(value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the user selection and navigate to the test screen
                // Here you can use selectedTheme and numberOfQuestions to generate the test
                // For example:
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TestScreen(theme: selectedTheme, numberOfQuestions: numberOfQuestions)));
              },
              child: Text('Start Test'),
            ),
          ],
        ),
      ),
    );
  }
}
