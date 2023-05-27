// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'cadastroExtintor_controller.dart';

class CadastroExtintorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastroExtintorController>(() => CadastroExtintorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
