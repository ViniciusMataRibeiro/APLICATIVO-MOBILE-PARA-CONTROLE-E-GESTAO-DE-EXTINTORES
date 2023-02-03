import 'package:cge_app/app/modules/vistoria/controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VistoriaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VistoriaController>(() => VistoriaController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
