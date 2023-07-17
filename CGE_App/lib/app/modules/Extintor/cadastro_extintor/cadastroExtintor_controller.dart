// ignore_for_file: file_names

import 'package:cge_app/app/data/Models/extintor_request_model.dart';
import 'package:cge_app/app/data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CadastroExtintorController extends GetxController {
  final _authService = Get.find<AuthService>();
  DateTime dt = DateTime.now();
  DateTime dt2 = DateTime.now();
  String selectedTamanho = '';
  String selectedTipo = '';

  var id = 0;
  // ignore: non_constant_identifier_names
  var setor_id = 0;

  var nome = TextEditingController(text: '');
  var validadeCasco = TextEditingController(text: '');
  var validadeExtintor = TextEditingController(text: '');
  var proximaManutencao = TextEditingController(text: '');
  var descricao = TextEditingController(text: '');
  var ativo = true.obs;

  var alterando = false;

  late Map _extintor;

  @override
  void onInit() {
    if (Get.arguments != null) {
      _extintor = Get.arguments;
      id = _extintor['id'];
      nome.text = _extintor['nome'];
      selectedTamanho = "${_extintor['tamanho'] ?? 0} Kg";
      selectedTipo = _extintor['tipoExtintor'];
      setor_id = _extintor['setor_id'];
      ativo = _extintor['ativo'] == 1 ? true.obs : false.obs;

      dt = DateTime.parse(_extintor['validadeCasco']);
      dt2 = DateTime.parse(_extintor['validadeExtintor']);

      alterando = true;
    } else {
      dt = DateTime.now();
      dt2 = DateTime.now();

      alterando = false;
    }

    super.onInit();
  }

  Future<String> goToInsert() async {
    if (nome.text == '') {
      return 'informe o numero do extintor';
    }

    if (selectedTamanho == '') {
      return 'informe o tamanho do extintor';
    }

    if (selectedTipo == '') {
      return 'informe o tipo do extintor';
    }

    if (validadeCasco.text == '') {
      validadeCasco.text = DateFormat('dd/MM/yyyy').format(dt);
    }

    if (validadeExtintor.text == '') {
      validadeExtintor.text = DateFormat('dd/MM/yyyy').format(dt2);
    }

    var extintorResquestModel = ExtintorRequestModel(
      id: id,
      nome: nome.text,
      validadeCasco: DateFormat('dd/MM/yyyy').parse(validadeCasco.text),
      validadeExtintor: DateFormat('dd/MM/yyyy').parse(validadeExtintor.text),
      tamanho: int.parse(selectedTamanho.replaceAll(RegExp(r'[^0-9]'), '')),
      tipo: selectedTipo,
      ativo: true,
      setor_id: 1,
      descricao: "Extintor Ativo no setor id 1",
    );

    bool res = false;

    if (id > 0) {
      res = await _authService.updateExtintor(extintorResquestModel);
    } else {
      res = await _authService.insertExtintor(extintorResquestModel);
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
