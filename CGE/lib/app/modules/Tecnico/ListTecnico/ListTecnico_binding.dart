// ignore_for_file: file_names
import 'package:flutter/services.dart';
import 'ListTecnico_controller.dart';
import 'package:get/get.dart';

class ListTecnicoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTecnicoController>(() => ListTecnicoController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}