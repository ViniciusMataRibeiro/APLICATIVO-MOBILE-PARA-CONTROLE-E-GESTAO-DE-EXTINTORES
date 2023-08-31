import 'package:flutter/services.dart';
import 'extintores_controller.dart';
import 'package:get/get.dart';

class ExtintorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtintorController>(() => ExtintorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
