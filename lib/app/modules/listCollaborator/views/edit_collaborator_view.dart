import 'package:challenge_web/app/data/models/collaborator_model.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/list_collaborator_controller.dart';

class EditCollaboratorView extends GetView<ListCollaboratorController> {
  final CollaboratorModel collaborator;

  EditCollaboratorView({super.key, required this.collaborator});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: collaborator.name);
    final registrationController = TextEditingController(text: collaborator.enrollment);
    final positionController = TextEditingController(text: collaborator.position);
    final salaryController = TextEditingController(
      text: NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(collaborator.salary),
    );

    final _formKey = GlobalKey<FormState>();

    void _cancelForm() {
      nameController.clear();
      registrationController.clear();
      positionController.clear();
      salaryController.clear();
    }

    void _submitForm(ListCollaboratorController controller) {
      String salaryText = salaryController.text.replaceAll('R\$', '').trim();
    salaryText = salaryText.replaceAll('.', '').replaceAll(',', '.');
      if (_formKey.currentState!.validate()) {
        final updatedCollaborator = CollaboratorModel(
          id: collaborator.id,
          name: nameController.text,
          enrollment: registrationController.text,
          position: positionController.text,
          salary: double.parse(salaryText),
        );
        controller.updateCollaborator(updatedCollaborator);
        Get.back();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Colaborador'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 350.0,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // This line ensures the Column takes only the necessary space
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: registrationController,
                  decoration: const InputDecoration(
                    labelText: 'Matrícula',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a matrícula';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: positionController,
                  decoration: const InputDecoration(
                    labelText: 'Cargo',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o cargo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                controller: salaryController,
                decoration: const InputDecoration(
                  labelText: 'Salário',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter.currency(
                    locale: 'pt_BR',
                    symbol: 'R\$',
                    decimalDigits: 2,
                  )
                ],
                validator: (value) {
                  value = value!.replaceAll(RegExp(r'[^\d.]'), '');
                  if (value.isEmpty) {
                    return 'Por favor, insira um salário.';
                  } else if (double.tryParse(value) == null) {
                    return 'Valor inválido.';
                  } else if (double.tryParse(value)! < 0) {
                    return 'O salário não pode ser negativo.';
                  }
                  return null;
                },
              ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _cancelForm,
                      child: const Text('Cancelar'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _submitForm(controller),
                      child: const Text('Salvar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}