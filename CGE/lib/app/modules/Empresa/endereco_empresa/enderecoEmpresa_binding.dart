// ignore_for_file: file_names
import 'enderecoEmpresa_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EnderecoEmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnderecoEmpresaController>(() => EnderecoEmpresaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
