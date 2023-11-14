// ignore_for_file: file_names
import 'package:cge_app/app/modules/qrCode/generetor/qr_controller_gerenetor.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QRCodeGeneretorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRCodeGeneretorController>(() => QRCodeGeneretorController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
