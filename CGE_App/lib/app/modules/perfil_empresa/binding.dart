import 'package:cge_app/app/modules/perfil_empresa/controller.dart';
import 'package:get/get.dart';



class PerfilEmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilEmpresaController>(() => PerfilEmpresaController());
  }
}