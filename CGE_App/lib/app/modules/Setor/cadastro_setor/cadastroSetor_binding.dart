import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'cadastroSetor_controller.dart';

class CadastroSetorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroSetorController>(() => CadastroSetorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
