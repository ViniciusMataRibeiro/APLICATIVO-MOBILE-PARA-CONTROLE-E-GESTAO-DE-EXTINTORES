import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/Models/user_login_request.dart';
import '../../data/services/auth/service.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _login = Get.find<AuthService>();

  var showPassword = true.obs;
  var emailController = TextEditingController(text: 'tecnico@email.com');
  var passwordController = TextEditingController(text: '123456');
  bool get isLogged => _login.isLogged;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<String> goTologin() async {
    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    var result =  await _authService.login(userLoginRequestModel);

    return result;
  }

  bool goTologout() {
    var result = _authService.logout().then((value) => null) as bool;

    return result;
  }
}
