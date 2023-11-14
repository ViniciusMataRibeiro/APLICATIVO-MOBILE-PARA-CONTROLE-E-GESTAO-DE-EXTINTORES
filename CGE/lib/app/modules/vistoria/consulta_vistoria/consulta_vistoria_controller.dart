import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';

class ConsultaVistoriaController extends GetxController {
  final _authService = Get.find<AuthService>();
  
  Future<Map> getAllManutencao() async {
    Map t = await _authService.getAllManutencao();

    return t;
  }
}
