import 'package:flutter/material.dart';
import 'verdadero_falso/true_false_odoo.dart'; // Importa la pantalla 1
import 'single_choice/single_choice_odoo.dart'; // Importa la pantalla 2
import 'multiple_choice/multiple_choice_odoo.dart'; // Importa la pantalla 3

void main() {
  runApp(TipoTest());
}

class TipoTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TipoTestOdoo(),
    );
  }
}

class TipoTestOdoo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona el tipo de Test a realizar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SCQuestionScreenOdoo()), // Navega a la pantalla 1
                );
              },
              child: Text('Single Choice'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MCQuestionScreenOdoo()), // Navega a la pantalla 2
                );
              },
              child: Text('Multiple Choice'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VFQuestionScreenOdoo()), // Navega a la pantalla 3
                );
              },
              child: Text('Verdadero Falso'),
            ),
          ],
        ),
      ),
    );
  }
}
