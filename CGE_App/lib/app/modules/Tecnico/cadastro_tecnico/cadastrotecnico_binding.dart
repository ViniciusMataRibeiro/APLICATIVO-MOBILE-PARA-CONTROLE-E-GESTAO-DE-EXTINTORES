import 'package:cge_app/app/modules/Tecnico/cadastro_tecnico/cadastrotecnico_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CadastroTecnicoBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CadastroTecnicoController>(() => CadastroTecnicoController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}