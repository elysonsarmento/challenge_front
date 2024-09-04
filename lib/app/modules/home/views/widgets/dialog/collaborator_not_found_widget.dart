import 'package:flutter/material.dart';

class CollaboratorNotFoundDialog extends StatelessWidget {
  const CollaboratorNotFoundDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Falha ao registrar saída'),
      content: const Text('Colaborador não encontrado.'),
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