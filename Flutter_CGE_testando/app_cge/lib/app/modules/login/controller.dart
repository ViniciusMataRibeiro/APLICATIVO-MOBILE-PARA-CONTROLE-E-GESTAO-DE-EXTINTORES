import 'package:app_cge/app/routes/routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void goTologin() {
    Get.toNamed(Routes.login);
  }
}
