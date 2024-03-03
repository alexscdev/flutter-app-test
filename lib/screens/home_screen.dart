import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tipo_test_screen_flutter.dart';
import 'tipo_test_screen_odoo.dart';
import 'tipo_test_screen_java.dart';

class HomeScreen extends StatelessWidget {
  final List<String> menuOptions = ['Ajustes', 'Perfil', 'Cerrar Sesion']; // Opciones del menú
  final List<String> buttonOptions = ['Flutter', 'Odoo', 'Java']; // Opciones para los botones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
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
                  ...menuOptions.map((String value) {
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
              // Muestra un diálogo de confirmación al pulsar el botón de salir
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Salir de la aplicación'),
                    content: Text('¿Seguro que desea salir de la aplicación?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Cierra el diálogo
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Cierra la aplicación
                          SystemNavigator.pop();
                        },
                        child: Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selecciona la tematica de la que quiere realizar el test:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: buttonOptions.map((option) {
                return ElevatedButton(
                  onPressed: () {
                    navigateToPage(context, option);
                  },
                  child: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, String selectedOption) {
    switch (selectedOption) {
      case 'Flutter':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TipoTestFlutter()),
        );
        break;
      case 'Odoo':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TipoTestOdoo()),
        );
        break;
      case 'Java':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TipoTestJava()),
        );
        break;
      default:
      // Handle other cases if needed
        break;
    }
  }
}
