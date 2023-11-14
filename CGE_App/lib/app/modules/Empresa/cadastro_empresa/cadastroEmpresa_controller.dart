// ignore_for_file: file_names
import 'package:cge_app/app/data/Models/empresa_request_model.dart';
import 'package:cge_app/app/data/Models/empresa_response_model.dart';
import 'package:cge_app/app/data/Models/endereco_request_model.dart';
import '../../../data/services/auth/service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroEmpresaController extends GetxController {
  final _authService = Get.find<AuthService>();
  var idEmpresa = 0;
  var idEndereco = 0;
  var alterando = false;

  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var password = TextEditingController(text: '');
  var telefone = TextEditingController(text: '');

  var cep = TextEditingController(text: '');
  var rua = TextEditingController(text: '');
  var cidade = TextEditingController(text: '');
  var bairro = TextEditingController(text: '');
  var numero = TextEditingController(text: '');
  var referencia = TextEditingController(text: '');
  var uf = TextEditingController(text: '');

  Future<String> goToInsert() async {
    if (name.text == '') {
      return 'Informe o nome';
    }
    if (email.text == '') {
      return 'Informe o email';
    }
    if (password.text == '') {
      return 'Informe a senha';
    }
    if (telefone.text == '') {
      return 'Informe o telefone';
    }

    var empresaRequestModel = EmpresaResquestModel(
      id: idEmpresa,
      nome: name.text,
      email: email.text,
      password: password.text,
      telefone: telefone.text,
    );

    EmpresaResponseModel result;
    if (idEmpresa > 0) {
      result = await _authService.updateEmpresa(empresaRequestModel);
    } else {
      result = await _authService.insertEmpresa(empresaRequestModel);
    }

    bool res = false;
    var enderecoRequestModel = EnderecoRequestModel(
      id: idEndereco,
      empresa_id: result.id,
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
