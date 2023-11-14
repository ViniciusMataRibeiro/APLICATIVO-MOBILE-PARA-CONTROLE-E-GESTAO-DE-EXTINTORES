import 'setor_details_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SetorDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetorDetailsController>(() => SetorDetailsController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
