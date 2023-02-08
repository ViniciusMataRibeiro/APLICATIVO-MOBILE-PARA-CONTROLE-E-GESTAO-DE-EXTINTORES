import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'setores_controller.dart';

class SetoresBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetorController>(() => SetorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
