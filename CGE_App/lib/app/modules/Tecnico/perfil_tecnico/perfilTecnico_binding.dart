// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'perfilTecnico_controller.dart';

class PerfilTecnicoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilTecnicoController>(() => PerfilTecnicoController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
