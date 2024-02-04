import 'package:flutter/material.dart';

class VFQuestionScreen extends StatefulWidget {
  const VFQuestionScreen({super.key});

  @override
  _VFQuestionScreenState createState() => _VFQuestionScreenState();
}

class _VFQuestionScreenState extends State<VFQuestionScreen> {
  String? selectedOption;

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
