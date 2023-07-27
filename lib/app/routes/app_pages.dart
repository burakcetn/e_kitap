import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/BookListen/index.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PLAYER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER,
      page: () => BooklistenPage(),
      binding: BooklistenBinding(),
    ),
  ];
}
