import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';

class PerfilEmpresaController extends GetxController {
  final _authService = Get.find<AuthService>();

  void goTologout() {
    _authService.logout().then((value) => null);
  }
}
