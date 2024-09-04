import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/listCollaborator/bindings/list_collaborator_binding.dart';
import '../modules/listCollaborator/views/list_collaborator_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIST_COLLABORATOR,
      page: () => ListCollaboratorView(),
      binding: ListCollaboratorBinding(),
    ),
  ];
}
