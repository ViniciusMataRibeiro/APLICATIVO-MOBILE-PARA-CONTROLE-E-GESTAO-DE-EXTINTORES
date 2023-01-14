import 'package:app_cge/app/modules/cadastro_setor/controller.dart';
import 'package:get/get.dart';

class CadastroSetorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroSetorController>(() => CadastroSetorController());
  }
}
