import '../../../data/repositories/collaborator_repository_impl.dart';
import '../../../data/repositories/point_repository_impl.dart';
import '../../../data/source/remote/collaborator_remote.dart';
import '../../../data/source/remote/point_remote.dart';
import '../../../domain/repositories/collaborator_repository.dart';
import '../../../domain/repositories/point_repository.dart';
import '../../../domain/usecase/collaborator_usecase.dart';
import '../../../domain/usecase/point_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../controllers/list_collaborator_controller.dart';

class ListCollaboratorBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<Dio>(() => Dio(
          BaseOptions(
            baseUrl: 'https://localhost:7060/api/v1/',
             validateStatus: (status) {
              return status! < 500;
            },
          ),
    ));


    //Source
    Get.lazyPut<CollaboratorRemote>(
        () => CollaboratorRemote(Get.find<Dio>()));

    Get.lazyPut<PointRemoteDataSource>(
      () => PointRemoteDataSource(dio:
          Get.find<Dio>()),
    );

    //Repository

    Get.lazyPut<ICollaboratorRepository>(
        () => CollaboratorRepositoryImpl(Get.find<CollaboratorRemote>()));

    Get.lazyPut<IPointRepository>(
      () =>
          PointRepository(remoteDataSource: Get.find<PointRemoteDataSource>()),
    );

    //UseCase
    Get.lazyPut<CollaboratorUseCases>(
        () => CollaboratorUseCases(Get.find<ICollaboratorRepository>()));
    Get.lazyPut(() => PointUsecase(repository: Get.find<IPointRepository>()));

    Get.lazyPut<ListCollaboratorController>(
      () => ListCollaboratorController(),
    );
  }
}
