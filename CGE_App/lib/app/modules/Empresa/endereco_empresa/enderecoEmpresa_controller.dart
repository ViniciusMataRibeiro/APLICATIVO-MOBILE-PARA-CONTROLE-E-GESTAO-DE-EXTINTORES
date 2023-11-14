// ignore_for_file: file_names
import '../../../data/Models/endereco_request_model.dart';
import '../../../data/services/auth/service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnderecoEmpresaController extends GetxController {
  final _authService = Get.find<AuthService>();

  var idEmpresa = 0;
  var idEndereco = 0;

  var alterando = false;
  var cep = TextEditingController(text: '');
  var rua = TextEditingController(text: '');
  var cidade = TextEditingController(text: '');
  var bairro = TextEditingController(text: '');
  var numero = TextEditingController(text: '');
  var referencia = TextEditingController(text: '');
  var uf = TextEditingController(text: '');

  @override
  Future<void> onInit() async {
    super.onInit();

    Map t = await _authService.getEnderecoEmpresa();
    var data = t['dados'];
    if (data != null) {
      alterando = true;
      idEndereco = data['id'];
      cep.text = data['cep'];
      rua.text = data['rua'];
      cidade.text = data['cidade'];
      bairro.text = data['bairro'];
      numero.text = data['numero'];
      referencia.text = data['ponto_referencia'] == null
          ? ''
          : data['ponto_referencia'].toString();
      uf.text = data['uf'];
    } else {
      alterando = false;
    }
  }

  Future<String> goToInsert() async {
    bool res = false;
    var enderecoRequestModel = EnderecoRequestModel(
      id: idEndereco,
      empresa_id: idEmpresa,
      cep: cep.text,
      rua: rua.text,
      cidade: cidade.text,
      bairro: bairro.text,
      numero: numero.text,
      ponto_referencia: referencia.text,
      uf: uf.text,
    );

    if (idEndereco > 0) {
      res = await _authService.updateEndereco(enderecoRequestModel);
    } else {
      res = await _authService.insertEndereco(enderecoRequestModel);
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
