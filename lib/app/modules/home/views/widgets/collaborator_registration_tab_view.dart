import 'package:challenge_web/app/data/models/collaborator_model.dart';
import 'package:challenge_web/app/modules/home/controllers/home_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CollaboratorRegistrationView extends StatelessWidget {
  final PageController pageController;
  final _formKey = GlobalKey<FormState>();

  CollaboratorRegistrationView({super.key, required this.pageController});

  void _submitForm(HomeController controller) {
    String salaryText = _salaryController.text.replaceAll('R\$', '').trim();
    salaryText = salaryText.replaceAll('.', '').replaceAll(',', '.');
    double salary = double.parse(salaryText);

    if (_formKey.currentState!.validate()) {
      final collaborator = CollaboratorModel(
        name: _nameController.text,
        enrollment: _registrationController.text,
        position: _roleController.text,
        salary: salary, 
      );

        controller.addCollaborator(collaborator);

        pageController.jumpToPage(0);
        _nameController.clear();
        _registrationController.clear();
        _roleController.clear();
        _salaryController.clear();
      
    }
  }

  void _cancelForm() {
    pageController.jumpToPage(0);
  }

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _registrationController = TextEditingController();
  final _roleController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Center(
      child: Container(
        width: 300.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: _formKey, // Add the form key here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome TextFormField
              TextFormField(
                controller: _nameController, // Associate the controller
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Matrícula TextFormField
              TextFormField(
                controller: _registrationController,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma matrícula.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Cargo TextFormField
              TextFormField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: 'Cargo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um cargo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Salário TextFormField
              TextFormField(
                controller: _salaryController,
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
              const SizedBox(height: 8),

              // Botões de Ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão Cancelar
                  TextButton(
                    onPressed: _cancelForm,
                    child: const Text('Cancelar'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),

                  // Botão Cadastrar
                  ElevatedButton(
                    onPressed: () => _submitForm(controller),
                    child: const Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
