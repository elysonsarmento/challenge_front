import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointAlreadyRegisteredWidget extends StatelessWidget {
  const PointAlreadyRegisteredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ponto já Registrado'),
      content: const Text('Você já registrou esse ponto hoje.'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}