import 'package:challenge_web/app/modules/home/controllers/home_controller.dart';
import 'package:challenge_web/app/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointRegistrationView extends StatelessWidget {
  final PageController pageController;

  PointRegistrationView({super.key, required this.pageController});
  final HomeController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final RxnString _selectedRegistrationType = RxnString();

  // Controller for the matricula TextField
  final TextEditingController _matriculaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.0,
        height: 270.0,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _matriculaController, // Associate the controller
                  decoration: const InputDecoration(
                    labelText: 'Matrícula',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    // final RegExp matriculaRegExp = RegExp(r'^[A-Za-z]{2}\d{4}$');
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma matrícula.';
                    }
                    // else if (!matriculaRegExp.hasMatch(value)) {
                    //   return 'Formato inválido. Use LL9999.';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Dropdown to select registration type
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Registro',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  value: _selectedRegistrationType.value,
                  items: const [
                    DropdownMenuItem(value: 'Entrada', child: Text('Entrada')),
                    DropdownMenuItem(value: 'Saída', child: Text('Saída')),
                  ],
                  onChanged: (value) {
                    _selectedRegistrationType.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione o tipo de registro.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                LoadingButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final matricula = _matriculaController.text;
                      if (_selectedRegistrationType.value == 'Entrada') {
                        controller.registrationPoint(matricula);
                      } else {
                        controller.registrationPointOut(matricula);
                      }
                    }
                  },
                  isLoading: controller.isLoading.value,
                  text: 'Registrar',
                ),
                const SizedBox(height: 16),
                // Botão para ir para a página de cadastro
                ElevatedButton(
                  onPressed: () {
                    pageController.jumpToPage(1);
                  },
                  child: const Text('Ir para Cadastro'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
