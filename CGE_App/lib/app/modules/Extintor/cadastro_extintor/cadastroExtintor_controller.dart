// ignore_for_file: file_names

import 'package:cge_app/app/data/Models/extintor_request_model.dart';
import 'package:cge_app/app/data/services/auth/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../data/Models/subject_data_model.dart';

class CadastroExtintorController extends GetxController {
  final _authService = Get.find<AuthService>();
  var id = 0;
  var setor_id = 0;

  var nome = TextEditingController(text: '');
  var validadeCasco = TextEditingController(text: '');
  var validadeExtintor = TextEditingController(text: '');
  var tamanho = TextEditingController(text: '');
  var tipoExtintor = TextEditingController(text: '');
  var proximaManutencao = TextEditingController(text: '');
  var descricao = TextEditingController(text: '');
  var ativo = true.obs;

  var alterando = false;

  late Map _extintor;


  @override
  void onInit() {
    if(Get.arguments != null){
      _extintor = Get.arguments;
      id = _extintor['id'];
      nome = _extintor['nome'];
      validadeCasco.text = _extintor['validadeCasco'];
      validadeExtintor.text = _extintor['validadeExtintor'];
      tamanho.text = _extintor['tamanho'];
      tipoExtintor.text = _extintor['tipoExtintor'];
      setor_id = _extintor['setor_id'];
      ativo = _extintor['ativo'] == 1 ? true.obs : false.obs;

      alterando = true;
    }
    else {
      alterando = false;
    }

    super.onInit();
  }

  Future<String> goToInsert() async{
    if(nome.text == ''){
      return 'informe a data';
    }
    if(validadeCasco.text == ''){
      return 'informe a data';
    }
    if(validadeExtintor.text == ''){
      return 'informe a data';
    }
    if(tamanho.text == ''){
      return 'informe o tamanho do extintor';
    }
    if(tipoExtintor.text == ''){
      return 'informe o tipo do extintor';
    }


    var extintorResquestModel = ExtintorRequestModel(
      id: id, 
      nome: nome.text, 
      validadeCasco: validadeCasco.text, 
      validadeExtintor: validadeExtintor.text, 
      tamanho: tamanho.text, 
      tipo: tipoExtintor.text,
      );

      bool res = false;

      if(id > 0){
        res = await _authService.updateExtintor(extintorResquestModel);
      }
      else{
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
