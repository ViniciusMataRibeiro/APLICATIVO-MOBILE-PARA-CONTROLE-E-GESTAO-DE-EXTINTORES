import '../../data/Models/user_login_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _login = Get.find<AuthService>();

  var showPassword = true.obs;
  var emailController = TextEditingController(text: 'gleison@email.com');
  var passwordController = TextEditingController(text: '123456');
  bool get isLogged => _login.isLogged;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<String> goTologin() async {
    var userLoginRequestModel = UserLoginRequestModel(
        email: emailController.text, password: passwordController.text);

    var result =_authService.login(userLoginRequestModel);

    return result;
  }

  void goTologout() {
    _authService.logout().then((value) => null);
  }

   Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        textColor: Colors.white,
        fontSize: 15,
        );
  }
}
