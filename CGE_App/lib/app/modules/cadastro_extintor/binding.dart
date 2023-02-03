import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CadastroExtintorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroExtintorController>(() => CadastroExtintorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
