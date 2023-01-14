import 'package:app_cge/app/modules/cadastro_extintor/controller.dart';
import 'package:get/get.dart';

class CadastroExtintorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroExtintorController>(() => CadastroExtintorController());
  }
}
