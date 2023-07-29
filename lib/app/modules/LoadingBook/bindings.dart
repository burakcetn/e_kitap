import 'package:get/get.dart';

import 'controller.dart';

class LoadingbookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingbookController>(() => LoadingbookController());
  }
}
