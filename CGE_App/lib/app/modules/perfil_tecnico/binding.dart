import 'package:get/get.dart';

import 'controller.dart';

class PerfilTecnicoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilTecnicoController>(() => PerfilTecnicoController());
  }
}
