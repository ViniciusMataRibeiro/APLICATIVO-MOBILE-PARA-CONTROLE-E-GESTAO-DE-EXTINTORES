import 'package:app_cge/app/modules/abas/controller.dart';
import 'package:get/get.dart';

class AbaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbaController>(() => AbaController());
  }
}
