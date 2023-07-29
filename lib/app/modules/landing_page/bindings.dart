import 'package:get/get.dart';

import 'controller.dart';

class LandingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingPageController>(() => LandingPageController());
  }
}
