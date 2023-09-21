import '../../../data/services/auth/service.dart';
import '../../../routes/routes.dart';
import 'package:get/get.dart';

class ExtintorController extends GetxController {
  final _authService = Get.find<AuthService>();

  Future<Map> getAllExtintor(bool isAtivo) async {
    Map t = await _authService.getAllExtintor(isAtivo);

    return t;
  }


  Future<void> gotoDeleteExtintor(int idExtintor) async {
    await _authService.deleteExtintor(idExtintor);
  }

  Future<void> gotoEditExtintor(Map item) async {
    await Get.toNamed(Routes.cadExtintor, arguments: item);
  }
}
