import 'package:challenge_web/app/modules/listCollaborator/controllers/list_collaborator_controller.dart';
import 'package:challenge_web/app/modules/listCollaborator/views/edit_collaborator_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CollaboratorsTab extends StatefulWidget {
  @override
  _CollaboratorsTabState createState() => _CollaboratorsTabState();
}

class _CollaboratorsTabState extends State<CollaboratorsTab> {
  final ListCollaboratorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isCollaboratorTabLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      columns: const [
                        DataColumn(
                            label: Center(
                                child: Text('Nome',
                                    style: TextStyle(fontWeight: FontWeight.bold)))),
                        DataColumn(
                            label: Center(
                                child: Text('Matrícula',
                                    style: TextStyle(fontWeight: FontWeight.bold)))),
                        DataColumn(
                            label: Center(
                                child: Text('Cargo',
                                    style: TextStyle(fontWeight: FontWeight.bold)))),
                        DataColumn(
                            label: Center(
                                child: Text('Salário',
                                    style: TextStyle(fontWeight: FontWeight.bold)))),
                        DataColumn(label: Text('')), 
                        DataColumn(label: Text('')), 
                      ],
                      rows: controller.collaborators.map((collaborator) {
                        return DataRow(
                          color: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.lightBlue.withOpacity(0.08);
                              }
                              return null;
                            },
                          ),
                          cells: [
                            DataCell(Center(
                                child: Text(
                                    collaborator.name))),
                            DataCell(Center(
                                child: Text(collaborator.enrollment))),
                            DataCell(Center(
                                child: Text(
                                    collaborator.position ?? 'Não disponível'))),
                            DataCell(Center(
                              child: Text(
                                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(collaborator.salary),
                              ),
                            )),
                            DataCell(
                              Center(
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Get.to(() => EditCollaboratorView(
                                        collaborator: collaborator));
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _showDeleteDialog(context, collaborator.id!);
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    );
  }

  void _showDeleteDialog(BuildContext context, int collaboratorId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar Colaborador'),
          content: const Text('Você tem certeza que deseja deletar este colaborador?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Deletar'),
              onPressed: () {
                controller.deleteCollaborator(collaboratorId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
