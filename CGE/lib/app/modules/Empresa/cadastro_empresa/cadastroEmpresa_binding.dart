// ignore_for_file: file_names
import 'cadastroEmpresa_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CadastroEmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroEmpresaController>(() => CadastroEmpresaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
