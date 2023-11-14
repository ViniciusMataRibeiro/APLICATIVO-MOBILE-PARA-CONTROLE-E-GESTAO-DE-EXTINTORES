// ignore_for_file: file_names
import '../../../data/services/auth/service.dart';
import '../../../data/Models/setor_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CadastroSetorController extends GetxController {
  final _authService = Get.find<AuthService>();
  var idSetor = 0;

  var name = TextEditingController();
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
    
    var setorRequestModel = SetorRequestModel(
        id: idSetor,
        name: name.text,
        descricao: descricao.text,
        ativo: ativo.value);

    int res = 0;

    if (idSetor > 0) {
      res = await _authService.updateSetor(setorRequestModel);
    } else {
      res = await _authService.insertSetor(setorRequestModel);
    }

    return res > 0 ? 'Setor-$res' : 'Algo deu Errado';
  }

  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
