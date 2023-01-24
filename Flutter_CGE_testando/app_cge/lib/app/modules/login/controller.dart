import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:app_cge/app/data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  var showPassword = true.obs;
  var emailController = TextEditingController(text: 'admin@email.com');
  var passwordController = TextEditingController(text: '123456');

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void goTologin() {
    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    _authService.login(userLoginRequestModel).then((value) => null);
  }
}
