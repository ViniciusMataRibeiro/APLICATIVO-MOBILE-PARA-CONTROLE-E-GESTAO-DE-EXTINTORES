import 'package:get/get.dart';

import '../../../data/Models/TecnicoModel.dart';
import '../../../data/provider/api.dart';
import '../../../data/services/auth/service.dart';

class ListTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();
  
  Future<List<TecnicoModel>> getTecnico(){
    return _authService.getTecnico();
  }
}