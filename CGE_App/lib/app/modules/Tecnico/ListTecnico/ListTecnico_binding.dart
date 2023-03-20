import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'ListTecnico_controller.dart';

class ListTecnicoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTecnicoController>(() => ListTecnicoController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}