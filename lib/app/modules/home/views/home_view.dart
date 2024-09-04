import 'package:challenge_web/app/modules/home/views/widgets/collaborator_registration_tab_view.dart';
import 'package:challenge_web/app/modules/home/views/widgets/point_registration_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final PageController _pageController = PageController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          PointRegistrationView(pageController: _pageController),
          CollaboratorRegistrationView(
            pageController: _pageController,
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.centerLeft,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/list-collaborator');
          },
          child: const Icon(Icons.view_list),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
