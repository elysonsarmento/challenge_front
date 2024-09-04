import 'package:challenge_web/app/modules/listCollaborator/controllers/list_collaborator_controller.dart';
import 'package:challenge_web/app/utils/months.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PointsTab extends StatefulWidget {
  PointsTab({super.key});

  @override
  _PointsTabState createState() => _PointsTabState();
}

class _PointsTabState extends State<PointsTab> {
  final ListCollaboratorController controller = Get.find();
  final TextEditingController _yearController = TextEditingController();
  String? _selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMonth = newValue;
                      });
                    },
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    underline: SizedBox(), // Remove the default underline
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ano',
                      border: InputBorder.none, // Remove the default border
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, 
                    ],
                    onFieldSubmitted: (value) {
                    },
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.getPoints(
                      month: months.indexOf(_selectedMonth!) + 1,
                      year: int.parse(_yearController.text),
                    );
                  },
                  child: const Text('Filtrar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedMonth = null;
                      _yearController.clear();
                    });
                    controller.getPoints();
                  },
                  child: const Text('Limpar Filtro'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isPointTabLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ScrollConfiguration(
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
                                    child: Text('Entrada',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))),
                            DataColumn(
                                label: Center(
                                    child: Text('Saída',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))),
                            DataColumn(
                                label: Center(
                                    child: Text('Timestamp In',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))),
                            DataColumn(
                                label: Center(
                                    child: Text('Timestamp Out',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))),
                            DataColumn(
                                label: Center(
                                    child: Text('Matrícula do Colaborador',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)))),
                          ],
                          rows: controller.points.map((point) {
                            return DataRow(
                              cells: [
                                DataCell(Center(
                                  child: Text(
                                    point.clockIn != null
                                        ? DateFormat('dd/MM/yyyy HH:mm:ss').format(point.clockIn!)
                                        : 'N/A',
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(
                                    point.clockOut != null
                                        ? DateFormat('dd/MM/yyyy HH:mm:ss').format(point.clockOut!)
                                        : 'N/A',
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(
                                    point.serverTimestampIn != null
                                        ? DateFormat('dd/MM/yyyy HH:mm:ss').format(point.serverTimestampIn!)
                                        : 'N/A',
                                  ),
                                )),
                                DataCell(Center(
                                  child: Text(
                                    point.serverTimestampOut != null
                                        ? DateFormat('dd/MM/yyyy HH:mm:ss').format(point.serverTimestampOut!)
                                        : 'N/A',
                                  ),
                                )),
                                DataCell(Center(child: Text(point.enrollment ?? 'N/A'))),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}