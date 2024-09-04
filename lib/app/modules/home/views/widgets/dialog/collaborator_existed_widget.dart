import 'package:flutter/material.dart';

class CollaboratorExistsDialog extends StatelessWidget {
  const CollaboratorExistsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erro'),
      content: const Text('Um colaborador com esta matrícula já existe.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}