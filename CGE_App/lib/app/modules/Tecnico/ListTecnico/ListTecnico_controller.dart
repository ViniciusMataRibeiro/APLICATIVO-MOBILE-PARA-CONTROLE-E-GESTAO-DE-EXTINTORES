import 'package:get/get.dart';

import '../../../data/Models/TecnicoModel.dart';
import '../../../data/provider/api.dart';
import '../../../data/services/auth/service.dart';

class ListTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();
  
  Future<List> getTecnico() async {

    List t = await _authService.getTecnico();

    return t;
  }
}