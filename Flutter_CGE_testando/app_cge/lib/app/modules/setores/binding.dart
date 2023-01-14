import 'package:app_cge/app/modules/setores/controller.dart';
import 'package:get/get.dart';

class SetoresBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetorController>(() => SetorController());
  }
}
