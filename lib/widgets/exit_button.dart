import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const PopupMenuItem<String>(
      value: 'Exit',
      child: Row(
        children: [
          Icon(Icons.exit_to_app),
          SizedBox(width: 8),
          Text('Salir'),
        ],
      ),
    );
  }
}
