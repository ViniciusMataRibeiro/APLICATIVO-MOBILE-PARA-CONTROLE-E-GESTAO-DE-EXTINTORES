// ignore_for_file: file_names
import 'perfilTecnico_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PerfilTecnicoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilTecnicoController>(() => PerfilTecnicoController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
