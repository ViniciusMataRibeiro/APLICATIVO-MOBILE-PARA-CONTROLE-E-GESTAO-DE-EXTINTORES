// ignore_for_file: prefer_typing_uninitialized_variables
import '../../../data/services/auth/service.dart';
import '../../../routes/routes.dart';
import 'package:get/get.dart';

class ExtintorSetorController extends GetxController {
  final _authService = Get.find<AuthService>();
  var idSetor;
  var nomeSetor;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      Map argu = Get.arguments;
      idSetor = argu['idsetor'];
      nomeSetor = argu['setor'];
    }
    super.onInit();
  }

  Future<Map> getExtintorSetor(int idSetor) async {
    Map t = await _authService.getExtintorSetor(idSetor);

    return t;
  }

  Future<void> gotoDeleteExtintor(int idExtintor) async {
    await _authService.deleteExtintor(idExtintor);

    Future.delayed(const Duration(milliseconds: 1), () {
      Get.offAllNamed(Routes.extintorSetor, arguments: {'idsetor': idSetor, 'setor': nomeSetor});
    });
  }

  Future<void> gotoEditExtintor(Map item) async {
    await Get.toNamed(Routes.cadExtintor, arguments: item);
  }
}
