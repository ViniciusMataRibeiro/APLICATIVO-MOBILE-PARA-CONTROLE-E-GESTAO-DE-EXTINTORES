import 'package:get/get.dart';

import 'controller.dart';

class CadastroSetorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroSetorController>(() => CadastroSetorController());
  }
}
