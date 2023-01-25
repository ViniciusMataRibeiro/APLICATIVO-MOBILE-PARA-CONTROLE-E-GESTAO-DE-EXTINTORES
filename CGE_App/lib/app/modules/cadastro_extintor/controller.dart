import 'package:get/get.dart';

class CadastroExtintorController extends GetxController {
  var _extintor = 0.obs;
  get extintor => _extintor.value;

  void changeExtintor(int value) {
    _extintor.value = value;
  }
}
