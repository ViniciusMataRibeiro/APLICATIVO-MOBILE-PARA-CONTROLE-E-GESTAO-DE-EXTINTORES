import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';
import '../../../routes/routes.dart';

class ExtintorController extends GetxController {
  final _authService = Get.find<AuthService>();

  Future<Map> getAllExtintor() async {
    Map t = await _authService.getAllExtintor();

    return t;
  }

  Future<void> gotoEditExtintor(Map item) async {
    await Get.toNamed(Routes.cadExtintor, arguments: item);
  }
}
