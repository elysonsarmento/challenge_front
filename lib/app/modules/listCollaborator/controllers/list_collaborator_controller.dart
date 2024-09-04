import 'package:challenge_web/app/data/models/collaborator_model.dart';
import 'package:challenge_web/app/data/models/timekeeping_model.dart';
import 'package:challenge_web/app/domain/usecase/collaborator_usecase.dart';
import 'package:challenge_web/app/domain/usecase/point_usecase.dart';
import 'package:challenge_web/app/modules/home/views/widgets/dialog/collaborator_existed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCollaboratorController extends GetxController {
  final isCollaboratorTabLoading = false.obs;
  final isPointTabLoading = false.obs;

  final _collaboratorsUsecase = Get.find<CollaboratorUseCases>();
  final _pointsUsecase = Get.find<PointUsecase>();

  final collaborators = <CollaboratorModel>[].obs;
  final points = <TimekeepingModel>[].obs;

  Future<void> getCollaborators({int? pageNumber, int? pageQuantity = 20}) async {
    try {
      isCollaboratorTabLoading.value = true;
      final data = await _collaboratorsUsecase.getCollaborators(
        pageNumber: pageNumber,
        pageQuantity: pageQuantity,
      );
      collaborators.assignAll(data);
      isCollaboratorTabLoading.value = false;
    } catch (e) {
      Exception('Failed to load collaborators: $e');
    }
  }

  Future<void> updateCollaborator(CollaboratorModel collaborator) async {
    try {
      isCollaboratorTabLoading.value = true;
      await _collaboratorsUsecase.updateCollaborator(collaborator);
      isCollaboratorTabLoading.value = false;
    } catch (e) {
      if (e
          .toString()
          .contains('A collaborator with this enrollment already exists')) {
        showDialog(
          context: Get.context!,
          builder: (context) => const CollaboratorExistsDialog(),
        );
      }
      Exception('Failed to update collaborator: $e');
    }
    await getCollaborators();
  }

  Future<void> deleteCollaborator(int id) async {
    try {
      isCollaboratorTabLoading.value = true;
      await _collaboratorsUsecase.deleteCollaborator(id);
      await getCollaborators();
      isCollaboratorTabLoading.value = false;
    } catch (e) {
      Exception('Failed to delete collaborator: $e');
    }
  }

  Future<void> getPoints({
    int pageNumber = 1,
    int pageSize = 20,
    int? month,
    int? year,
  }) async {
    try {
      isPointTabLoading.value = true;
      final data = await _pointsUsecase.getAll(
        pageNumber: pageNumber,
        pageSize: pageSize,
        month: month,
        year: year,
      );
      points.assignAll(data);
      isPointTabLoading.value = false;
    } catch (e) {
      Exception('Failed to load points: $e');
    }
  }

  @override
  void onInit() async {
    await getCollaborators();
    await getPoints();
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
