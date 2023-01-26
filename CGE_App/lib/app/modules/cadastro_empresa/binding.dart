import 'package:get/get.dart';

import 'controller.dart';

class CadastroEmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroEmpresaController>(() => CadastroEmpresaController());
  }
}
