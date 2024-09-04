import 'package:challenge_web/app/data/models/collaborator_model.dart';
import 'package:challenge_web/app/data/models/timekeeping_model.dart';
import 'package:challenge_web/app/domain/usecase/collaborator_usecase.dart';
import 'package:challenge_web/app/domain/usecase/point_usecase.dart';
import 'package:challenge_web/app/modules/home/views/widgets/dialog/collaborator_existed_widget.dart';
import 'package:challenge_web/app/modules/home/views/widgets/dialog/collaborator_not_found_widget.dart';
import 'package:challenge_web/app/modules/home/views/widgets/dialog/point_already_registered_widget.dart';
import 'package:challenge_web/app/modules/home/views/widgets/dialog/point_clockin_no_found_widget.dart';
import 'package:challenge_web/app/modules/home/views/widgets/dialog/sucess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final collaboratorsUsecase = Get.find<CollaboratorUseCases>();
  final collaborators = <CollaboratorModel>[].obs;
  final pointUsecase = Get.find<PointUsecase>();

  final isLoading = false.obs;

  Future<void> getCollaborators() async {
    try {
      final data = await collaboratorsUsecase.getCollaborators();
      collaborators.assignAll(data);
    } catch (e) {
      Exception('Failed to load collaborators: $e');
    }
  }

  Future<void> addCollaborator(CollaboratorModel collaborator) async {
    try {
      await collaboratorsUsecase.addCollaborator(collaborator);
      getCollaborators();
    } catch (e) {Exception('Failed to add collaborator: $e');
      if (e
          .toString()
          .contains('A collaborator with this enrollment already exists')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const CollaboratorExistsDialog(),
        );
        
      }
      throw  Exception('Failed to add collaborator: $e');
    }
  }

  Future<void> registrationPoint(String enrolment) async {
    final _time = TimekeepingModel(
      enrollment: enrolment,
      clockIn: DateTime.now(),
    );
    try {
      isLoading.value = true;
      await pointUsecase.clockIn(_time);
      showDialog(
        context: Get.context!,
        builder: (context) => const SuccessDialog(),
      );
      isLoading.value = false;
    } catch (e) {
      if (e.toString().contains('PointControllerError.clockIn')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const PointAlreadyRegisteredWidget(),
        );
      } else if (e
          .toString()
          .contains('PointControllerError.collaboratorNotFound')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const CollaboratorNotFoundDialog(),
        );
      }
      Exception('Failed to registration point: $e');
    }
  }

  Future<void> registrationPointOut(String enrolment) async {
    final _time = TimekeepingModel(
      enrollment: enrolment,
      clockOut: DateTime.now(),
    );
    try {
      isLoading.value = true;
      await pointUsecase.clockOut(_time);
      showDialog(
        context: Get.context!,
        builder: (context) => const SuccessDialog(),
      );
      isLoading.value = false;
    } catch (e) {
      if (e.toString().contains('PointControllerError.clockOut')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const PointAlreadyRegisteredWidget(),
        );
      } else if (e.toString().contains(
          'No clock-in found for the specified collaborator and day')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const NoClockInFoundDialog(),
        );
      } else if (e.toString().contains('Collaborator not found')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const CollaboratorNotFoundDialog(),
        );
      }
      Exception('Failed to registration point: $e');
    }
  }

  @override
  void onInit() {
    getCollaborators();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
