import 'extintores_details_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExtintorDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtintorDetailsController>(() => ExtintorDetailsController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
