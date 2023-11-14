import 'package:get/get.dart';

class QRCodeScannerController extends GetxController {
  bool isScanComplete = false;
  String data = '';

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      Map qrCode = Get.arguments;
      data = qrCode['dataQrCode'];
    } else {
      data = '';
    }

    super.onInit();
  }

  Future<void> verificaQrCode(String? rawValue) async {
    if (rawValue != null) {
      isScanComplete = true;
      final dataQrCode = rawValue.split('-');

      if (dataQrCode[0] == 'Extintor') {
        Get.toNamed('/detailsExtintor', arguments: dataQrCode[1]);
      } else {}

      isScanComplete = false;
    }
  }
}
