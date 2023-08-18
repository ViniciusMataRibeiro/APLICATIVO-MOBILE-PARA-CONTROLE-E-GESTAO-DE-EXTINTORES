import 'package:get/get.dart';

class QRCodeScannerController extends GetxController {
  bool isScanComplete = false;
  String data = '';

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      if (Get.arguments != null) {
        Map _qrCode = Get.arguments;
        data = _qrCode['dataQrCode'];
      } else {
        data = '';
      }
    } else {
      super.onInit();
    }
  }

  Future<void> verificaQrCode(String? rawValue) async {
    if (rawValue != null) {
      isScanComplete = true;

      //await Get.toNamed(Routes.cadExtintor);
    } else {
      isScanComplete = false;
    }
  }
}
