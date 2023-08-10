import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/services/auth/service.dart';

class VistoriaController extends GetxController {
  final _authService = Get.find<AuthService>();

  List dadosExtintor = [];

  DateTime dt = DateTime.now();
  bool isSelectmanometro = false;
  bool isSelectparede = false;
  bool isSelectpiso = false;
  bool isSelectacesso = false;
  bool isSelectmangueira = false;
  bool isSelectlacre = false;
  bool isSelectaprovado = false;
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
}