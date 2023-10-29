// ignore_for_file: file_names
import '../../../data/services/auth/service.dart';
import 'package:get/get.dart';

class PerfilEmpresaController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _login = Get.find<AuthService>();
  bool get isLogged => _login.isLogged;

  void goTologout() {
    _authService.logout().then((value) => null);
  }

  void goToEditEndereco() {
    Get.toNamed('/enderecoEmpresa');
  }
}
