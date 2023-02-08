import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/Models/user_login_request.dart';
import '../../data/services/auth/service.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _login = Get.find<AuthService>();

  var showPassword = true.obs;
  var emailController = TextEditingController(text: 'admin@email.com');
  var passwordController = TextEditingController(text: '123456');
  bool get isLogged => _login.isLogged;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void goTologin() {
    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    _authService.login(userLoginRequestModel).then((value) => null);
  }
}
