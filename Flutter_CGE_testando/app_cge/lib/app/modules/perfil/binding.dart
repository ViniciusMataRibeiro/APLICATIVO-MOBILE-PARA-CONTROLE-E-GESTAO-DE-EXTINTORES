import 'package:app_cge/app/modules/perfil/controller.dart';
import 'package:get/get.dart';

class PerfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilController>(() => PerfilController());
  }
}
