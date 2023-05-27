import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';
import '../../../routes/routes.dart';

class SetorController extends GetxController {
  final _authService = Get.find<AuthService>();

  Future<Map> getResumoSetor() async {
    Map t = await _authService.getResumoSetor();

    return t;
  }

  Future<void> gotoEditSetor(Map item) async {
    await Get.toNamed(Routes.cadSetor, arguments: item);
  }
}
