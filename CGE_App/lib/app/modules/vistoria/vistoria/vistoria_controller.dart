import 'package:cge_app/app/data/Models/vistoria_request_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/services/auth/service.dart';

class VistoriaController extends GetxController {
  final _authService = Get.find<AuthService>();

  List dadosExtintor = [];

  var id = 0;
  DateTime dt = DateTime.now();
  bool isSelectmanometro = false;
  bool isSelectparede = false;
  bool isSelectpiso = false;
  bool isSelectacesso = false;
  bool isSelectmangueira = false;
  bool isSelectlacre = false;
  bool isSelectaprovado = true;
  int idExtintor = 0;
  String nomeExtintor = '';
  int idSetor = 0;
  String nomeSetor = '';

  var descricao = TextEditingController(text: '');

  Future<Map> getSetores() async {
    Map t = await _authService.getSetores();

    return t;
  }

  Future<void> getExtintores(int idSetor) async {
    dadosExtintor = [];
    var res = (await _authService.getExtintorVistoria(idSetor)).toList();
    for (var item in res) {
      dadosExtintor.add(item);
    }
  }

  Future<String> goToInsert() async {
    var dt = DateTime.now();
    String updatedDt = DateFormat('dd/MM/yyyy').format(dt);

    var vistoriaRequestModel = VistoriaRequestModel(
      id: id,
      extintor_id: idExtintor,
      tecnico_id: 0,
      dataManutencao: DateFormat('dd/MM/yyyy').parse(updatedDt),
      manimetro: isSelectmanometro,
      sinalizacaoParede: isSelectparede,
      sinalizacaoPiso: isSelectpiso,
      acesso: isSelectacesso,
      mangueira: isSelectmangueira,
      lacre: isSelectlacre,
      aprovado: isSelectaprovado,
      descricao: descricao.text,
    );

    bool res = false;

    if (id > 0) {
      res = await _authService.updateVistoria(vistoriaRequestModel);
    } else {
      res = await _authService.insertVistoria(vistoriaRequestModel);
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
