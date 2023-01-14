import 'package:app_cge/app/modules/extintores/controller.dart';
import 'package:get/get.dart';

class ExtintorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtintorController>(() => ExtintorController());
  }
}
