// ignore_for_file: file_names
import 'package:cge_app/app/modules/qrCode/print_out_qrcode/print_out_qrcode_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PrintQrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrintQrCodeController>(() => PrintQrCodeController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
