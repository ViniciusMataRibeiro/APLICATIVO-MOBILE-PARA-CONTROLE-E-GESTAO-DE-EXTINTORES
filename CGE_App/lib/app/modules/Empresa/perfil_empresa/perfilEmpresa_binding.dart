import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'PerfilEmpresa_controller.dart';


class PerfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilController>(() => PerfilController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
