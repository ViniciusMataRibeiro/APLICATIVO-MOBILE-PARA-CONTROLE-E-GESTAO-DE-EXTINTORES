import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'extintores_controller.dart';

class ExtintorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtintorController>(() => ExtintorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
