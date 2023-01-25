import 'package:get/get.dart';

import 'controller.dart';

class AbaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbaController>(() => AbaController());
  }
}
