import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PerfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilController>(() => PerfilController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
