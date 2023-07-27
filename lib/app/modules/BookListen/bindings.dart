import 'package:get/get.dart';

import 'controller.dart';

class BooklistenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BooklistenController>(() => BooklistenController());
  }
}
