import 'package:cge_app/app/modules/Empresa/perfil_empresa/perfilEmpresa_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class PerfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilEmpresaController>(() => PerfilEmpresaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
