import 'package:get/get.dart';

class QRCodeGeneretorController extends GetxController {
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
}
