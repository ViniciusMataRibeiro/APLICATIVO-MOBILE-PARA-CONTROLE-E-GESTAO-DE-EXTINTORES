import 'package:get/get.dart';

import '../../data/services/auth/service.dart';

class AdminController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _login = Get.find<AuthService>();
  bool get isLogged => _login.isLogged;

  void goTologout() {
    _authService.logout().then((value) => null);
  }
}
