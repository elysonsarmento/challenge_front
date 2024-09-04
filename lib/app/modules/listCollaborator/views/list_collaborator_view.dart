import 'package:challenge_web/app/modules/listCollaborator/views/widgets/colaboradores_tab_view.dart';
import 'package:challenge_web/app/modules/listCollaborator/views/widgets/points_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCollaboratorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAndToNamed('/home');
            },
          ),
          title: Text('Gestão de Colaboradores'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Colaboradores'),
              Tab(text: 'Pontos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CollaboratorsTab(), 
            PointsTab(),     
          ],
        ),
      ),
    );
  }
}
