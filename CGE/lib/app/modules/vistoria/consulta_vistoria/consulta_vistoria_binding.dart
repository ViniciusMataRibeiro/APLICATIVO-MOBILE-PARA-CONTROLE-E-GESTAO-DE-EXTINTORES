import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'consulta_vistoria_controller.dart';

class ConsultaVistoriaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultaVistoriaController>(() => ConsultaVistoriaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}