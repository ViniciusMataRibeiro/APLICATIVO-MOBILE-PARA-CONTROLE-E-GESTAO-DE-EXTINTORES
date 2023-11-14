// ignore_for_file: file_names
import 'cadastroSetor_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CadastroSetorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroSetorController>(() => CadastroSetorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
