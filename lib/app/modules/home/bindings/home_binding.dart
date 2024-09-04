import 'package:challenge_web/app/data/repositories/collaborator_repository_impl.dart';
import 'package:challenge_web/app/data/repositories/point_repository_impl.dart';
import 'package:challenge_web/app/data/source/remote/collaborator_remote.dart';
import 'package:challenge_web/app/data/source/remote/point_remote.dart';
import 'package:challenge_web/app/domain/repositories/collaborator_repository.dart';
import 'package:challenge_web/app/domain/repositories/point_repository.dart';
import 'package:challenge_web/app/domain/usecase/collaborator_usecase.dart';
import 'package:challenge_web/app/domain/usecase/point_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio(
          BaseOptions(
            baseUrl: 'https://localhost:7060/api/v1',
            validateStatus: (status) {
              return status! < 500;
            },
            
          ),
          
        ));

    //Source
    Get.lazyPut<CollaboratorRemote>(
        () => CollaboratorRemote(Get.find<Dio>(),));

    Get.lazyPut<PointRemoteDataSource>(
      () => PointRemoteDataSource(dio: Get.find<Dio>()),
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

    Get.lazyPut<HomeController>(
      () => HomeController()..onInit(),
    );
  }
}
