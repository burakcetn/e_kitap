import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/BookListen/index.dart';
import 'package:getx_skeleton/app/modules/landing_page/index.dart';
import 'package:googleapis/dfareporting/v4.dart';

import '../../drawer.dart';
import '../modules/Contact/bindings.dart';
import '../modules/Contact/view.dart';
import '../modules/LoadingBook/bindings.dart';
import '../modules/LoadingBook/view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOADING;

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
      name: _Paths.LOADING,
      page: () => LoadingbookPage(),
      binding: LoadingbookBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => LandingPagePage(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => ContactPage(),
      binding: ContactBinding(),
    ),
  ];
}
