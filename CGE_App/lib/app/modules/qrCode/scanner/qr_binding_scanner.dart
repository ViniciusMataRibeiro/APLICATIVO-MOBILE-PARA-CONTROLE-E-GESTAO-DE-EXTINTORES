// ignore_for_file: file_names
import 'package:cge_app/app/modules/qrCode/scanner/qr_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QRCodeScannerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRCodeScannerController>(() => QRCodeScannerController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
