import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';

class SetorController extends GetxController {
  final _authService = Get.find<AuthService>();

  Future<Map> getResumoSetor() async {

    Map t = await _authService.getResumoSetor();

    return t;

    
  }

}
