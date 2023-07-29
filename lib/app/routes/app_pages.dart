import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/BookListen/index.dart';
import 'package:getx_skeleton/app/modules/landing_page/index.dart';
import 'package:googleapis/dfareporting/v4.dart';

import '../../drawer.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

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
    GetPage(
      name: _Paths.LANDING,
      page: () => LandingPagePage(),
      binding: LandingPageBinding(),
    ),
  ];
}
