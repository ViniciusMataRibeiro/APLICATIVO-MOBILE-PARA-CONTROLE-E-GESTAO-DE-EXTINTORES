import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/Models/setor_request.dart';
import '../../../data/services/auth/service.dart';

class CadastroSetorController extends GetxController {
  final _authService = Get.find<AuthService>();
  var idSetor = 0;

  var name = TextEditingController(text: '');
  var descricao = TextEditingController(text: '');
  var ativo = true.obs;

  var alterando = false;
  late Map _setor;

  @override
  void onInit() {
    if (Get.arguments != null) {
      _setor = Get.arguments;
      idSetor = _setor['idsetor'];
      name.text = _setor['setor'];
      descricao.text = _setor['descricao'] ?? '';
      ativo = _setor['ativo'] == 1 ? true.obs : false.obs;

      alterando = true;
    } else {
      alterando = false;
    }

    super.onInit();
  }

  Future<String> goToInsert() async {
    if (name.text == '') {
      return 'Informe o nome';
    }

    var setorRequestModel = SetorRequestModel(
        id: idSetor,
        name: name.text,
        descricao: descricao.text,
        ativo: ativo.value);

    bool res = false;

    if (idSetor > 0) {
      res = await _authService.updateSetor(setorRequestModel);
    } else {
      res = await _authService.insertSetor(setorRequestModel);
    }

    return res == true ? 'true' : 'Algo deu Errado';
  }

  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
