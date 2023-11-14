import 'package:flutter/services.dart';
import 'setores_controller.dart';
import 'package:get/get.dart';

class SetoresBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetorController>(() => SetorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
