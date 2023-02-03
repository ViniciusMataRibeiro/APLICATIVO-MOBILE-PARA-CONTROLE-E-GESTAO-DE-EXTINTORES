import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SetoresBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetorController>(() => SetorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
