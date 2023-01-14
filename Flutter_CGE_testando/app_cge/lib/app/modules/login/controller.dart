import 'package:get/get.dart';

class LoginController extends GetxController {
  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
