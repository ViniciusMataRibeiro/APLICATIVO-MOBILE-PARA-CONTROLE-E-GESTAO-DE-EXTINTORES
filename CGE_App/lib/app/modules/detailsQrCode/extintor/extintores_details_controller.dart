// ignore_for_file: non_constant_identifier_names
import '../../../data/services/auth/service.dart';
import '../../../routes/routes.dart';
import 'package:get/get.dart';

class ExtintorDetailsController extends GetxController {
  final _authService = Get.find<AuthService>();
  late String extintor_id;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      extintor_id = Get.arguments;
    }

    super.onInit();
  }

  Future<Map> getExtintor() async {
    Map t = await _authService.getByIdExtintor(int.parse(extintor_id));

    return t;
  }

  Future<void> gotoEditExtintor(Map item) async {
    Map<String, dynamic> extintor = {
      "id": item['extintor_id'],
      "nome": item['nome'],
      "tamanho": item['tamanho'],
      "tipoExtintor": item['tipoExtintor'],
      "setor_id": item['setor_id'],
      "setor": item['setor'],
      "validadeCasco": item['validadeCasco'],
      "validadeExtintor": item['validadeExtintor'],
      "proximaManutencao": item['proximaManutencao'],
      "descricao": item['descricao'],
      "ativo": item['ativo'],
    };

    await Get.toNamed(Routes.cadExtintor, arguments: extintor);
  }

  Future<void> gotovistoria(Map item) async {
    Map<String, dynamic> extintor = {
      "id": item['extintor_id'],
      "nome": item['nome'],
      "setor_id": item['setor_id'],
      "setor": item['setor'],
    };
    
    await Get.toNamed(Routes.vistoria, arguments: extintor);
  }

  Future<void> gotoDeleteExtintor(Map item) async {
    await _authService.deleteExtintor(item['extintor_id']);
    Get.back();
  }
}
