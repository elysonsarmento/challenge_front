import 'package:flutter/material.dart';

class NoClockInFoundDialog extends StatelessWidget {
  const NoClockInFoundDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Falha ao registrar saída'),
      content: const Text('Nenhum registro de entrada encontrado para o colaborador e dia especificados.'),
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