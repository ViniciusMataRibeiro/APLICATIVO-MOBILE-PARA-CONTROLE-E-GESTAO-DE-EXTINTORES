// ignore_for_file: file_names
import 'package:flutter/services.dart';
import 'perfilEmpresa_controller.dart';
import 'package:get/get.dart';

class PerfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilEmpresaController>(() => PerfilEmpresaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
