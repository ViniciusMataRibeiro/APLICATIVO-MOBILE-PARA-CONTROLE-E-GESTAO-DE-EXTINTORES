// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'enderecoEmpresa_controller.dart';

class EnderecoEmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnderecoEmpresaController>(() => EnderecoEmpresaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
