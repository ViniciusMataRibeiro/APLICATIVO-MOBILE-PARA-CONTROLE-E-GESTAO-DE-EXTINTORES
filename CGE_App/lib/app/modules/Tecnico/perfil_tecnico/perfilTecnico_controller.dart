// ignore_for_file: file_names
import '../../../data/services/auth/service.dart';
import 'package:get/get.dart';

class PerfilTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();

  void goTologout() {
    _authService.logout().then((value) => null);
  }
}
