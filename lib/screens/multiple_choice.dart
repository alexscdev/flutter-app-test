import 'package:flutter/material.dart';

class MCQuestionScreen extends StatefulWidget {
  const MCQuestionScreen({super.key});

  @override
  _MCQuestionScreenState createState() => _MCQuestionScreenState();
}

class _MCQuestionScreenState extends State<MCQuestionScreen> {
  List<String> selectedOptions = [];

  // Lista de opciones para la pregunta
  final List<String> options = [
    'Madrid',
    'Londres',
    'París',
    'Berlín',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta de Test'),
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
