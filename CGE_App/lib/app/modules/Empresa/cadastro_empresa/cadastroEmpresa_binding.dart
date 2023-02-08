import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'CadastroEmpresa_controller.dart';

class CadastroEmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroEmpresaController>(() => CadastroEmpresaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
