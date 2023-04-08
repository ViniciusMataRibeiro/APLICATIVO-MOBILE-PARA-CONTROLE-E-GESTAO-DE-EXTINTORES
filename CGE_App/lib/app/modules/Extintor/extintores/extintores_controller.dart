import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';

class ExtintorController extends GetxController {
  final _authService = Get.find<AuthService>();

  Future<Map> getAllExtintor() async {
    Map t = await _authService.getAllExtintor();

    return t;
  }
}
