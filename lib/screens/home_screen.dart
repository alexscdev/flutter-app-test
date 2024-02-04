import 'package:flutter/material.dart';
import 'package:app_test/screens/single_choice.dart';
import 'package:app_test/screens/true_false.dart';
import 'package:app_test/screens/multiple_choice.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final List<String> options = ['Test VF', 'Test SC', 'Test MC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  final screenSize = MediaQuery.of(context).size;

                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      screenSize.width - 100,
                      kToolbarHeight,
                      screenSize.width,
                      kToolbarHeight + 50,
                    ),
                    items: <PopupMenuEntry>[
                      ...options.map((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ],
                  ).then((value) {
                    if (value != null) {
                      navigateToPage(context, value);
                    }
                  });
                },
              ),
              SizedBox(width: 8), // Espacio entre los botones
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  // Lógica para salir de la aplicación
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selecciona una opción:',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, String selectedOption) {
    switch (selectedOption) {
      case 'Test SC':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SCQuestionScreen()),
        );
        break;
      case 'Test VF':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VFQuestionScreen()),
        );
        break;
      case 'Test MC':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MCQuestionScreen()),
        );
        break;
      default:
      // Handle other cases if needed
        break;
    }
  }
}

