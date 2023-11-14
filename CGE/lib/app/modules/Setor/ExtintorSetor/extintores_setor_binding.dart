import 'package:CGE/app/modules/Setor/ExtintorSetor/extintores_setor_controller.dart';
import 'package:get/get.dart';

class ExtintorSetorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtintorSetorController>(() => ExtintorSetorController());
  }
}