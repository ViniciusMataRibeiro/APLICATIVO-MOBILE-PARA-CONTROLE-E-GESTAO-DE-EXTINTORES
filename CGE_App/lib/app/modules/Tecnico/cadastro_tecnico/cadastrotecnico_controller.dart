import 'package:cge_app/app/data/Models/tecnico_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/Models/TecnicoModel.dart';
import '../../../data/services/auth/service.dart';

class CadastroTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _cadastroTecnico = Get.find<AuthService>();

  var showPassword = true.obs;
  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var password = TextEditingController(text: '');
  late Map _tecnico;

  @override
  void onInit() {
    if (Get.arguments != null) {
      _tecnico = Get.arguments;
      name.text = _tecnico['nome'];
      email.text = _tecnico['email'];
    }

    super.onInit();
  }

  void goToInsert() {
    var tecnicoRequestModel = TecnicoRequestModel(
        email: email.text, password: password.text, name: name.text);

    if (Get.arguments != null) {
      //_authService.InsertTecnico(tecnicoRequestModel).then((value) => null);
    }else{
        _authService.InsertTecnico(tecnicoRequestModel).then((value) => null);
    }
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
