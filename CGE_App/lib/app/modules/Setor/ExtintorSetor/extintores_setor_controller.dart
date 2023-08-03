import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';
import '../../../routes/routes.dart';

class ExtintorSetorController extends GetxController{
  final _authService = Get.find<AuthService>();
  var idSetor;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      Map argu = Get.arguments;
      idSetor = argu['idsetor'];
    }
    super.onInit();
  }

  Future<Map> getExtintorSetor(int idSetor) async {
    Map t = await _authService.getExtintorSetor(idSetor);

    return t;
  }

  Future<void> gotoEditExtintor(Map item) async {
    await Get.toNamed(Routes.cadExtintor, arguments: item);
  }
}