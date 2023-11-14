import 'package:get/get.dart';

class PrintQrCodeController extends GetxController {
  String tipo = '';
  String nome = '';
  String data = '';
  String tipoExtintor = '';

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      tipo = Get.arguments['tipo'];
      nome = Get.arguments['nome'];
      data = Get.arguments['result'];
      tipoExtintor = Get.arguments['tipoExtintor'];
    }

    super.onInit();
  }
}
