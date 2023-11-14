// ignore_for_file: file_names
import 'package:cge_app/app/data/Models/extintor_request_model.dart';
import 'package:cge_app/app/data/services/auth/service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../../routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CadastroExtintorController extends GetxController {
  final _authService = Get.find<AuthService>();
  DateTime dt = DateTime.now();
  DateTime dt2 = DateTime.now();
  DateTime dt3 = DateTime.now();
  String selectedTamanho = '';
  String selectedTipo = '';
  int idSetor = 0;
  String nomeSetor = '';
  bool isAtivo = true;

  var id = 0;

  var nome = TextEditingController();
  var validadeCasco = TextEditingController(text: '');
  var validadeExtintor = TextEditingController(text: '');
  var proximaManutencao = TextEditingController(text: '');
  var descricao = TextEditingController(text: '');

  List dadosExtintorTamanho = [];
  List dadosExtintorTipo = [];

  var alterando = false;

  late Map _extintor;
  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      alterando = true;
      _extintor = Get.arguments;
      id = _extintor['id'];
      nome.text = _extintor['nome'];
      selectedTamanho = "${_extintor['tamanho'] ?? 0} Kg";
      selectedTipo = _extintor['tipoExtintor'];
      idSetor = _extintor['setor_id'];
      nomeSetor = _extintor['setor'];
      isAtivo = _extintor['ativo'] == 1 ? true : false;

      dt = DateTime.parse(_extintor['validadeCasco']);
      dt2 = DateTime.parse(_extintor['validadeExtintor']);
      dt3 = DateTime.parse(_extintor['proximaManutencao']);
    } else {
      dt = DateTime.now();
      dt2 = DateTime.now();
      alterando = false;
    }

    super.onInit();
  }

  Future<void> getTamanhoExtintor() async {
    int j = 0;
    for (var i = 2; j < 4; i++) {
      j++;
      var kg = i + 2;
      i++;
      Map<String, dynamic> t = {
        "id": id,
        "nome": "$kg Kg",
      };
      dadosExtintorTamanho.add(t);
    }
  }

  Future<void> getTipoExtintor() async {
    Map<String, dynamic> t1 = {
      "id": 1,
      "nome": "Tipo A",
    };
    dadosExtintorTipo.add(t1);

    Map<String, dynamic> t2 = {
      "id": 2,
      "nome": "Tipo B",
    };
    dadosExtintorTipo.add(t2);

    Map<String, dynamic> t3 = {
      "id": 3,
      "nome": "Tipo AB",
    };
    dadosExtintorTipo.add(t3);

    Map<String, dynamic> t4 = {
      "id": 4,
      "nome": "Tipo BC",
    };
    dadosExtintorTipo.add(t4);

    Map<String, dynamic> t5 = {
      "id": 5,
      "nome": "Tipo ABC",
    };
    dadosExtintorTipo.add(t5);

    Map<String, dynamic> t6 = {
      "id": 6,
      "nome": "Tipo C",
    };
    dadosExtintorTipo.add(t6);

    Map<String, dynamic> t7 = {
      "id": 7,
      "nome": "Tipo D",
    };
    dadosExtintorTipo.add(t7);

    Map<String, dynamic> t8 = {
      "id": 8,
      "nome": "Tipo K",
    };
    dadosExtintorTipo.add(t8);

    Map<String, dynamic> t9 = {
      "id": 9,
      "nome": "Tipo CO²",
    };
    dadosExtintorTipo.add(t9);
  }

  Future<Map> getSetores() async {
    Map t = await _authService.getSetores();

    return t;
  }

  Future<String> goToInsert() async {
    // if (nome.text == '') {
    //   return 'informe o numero do extintor';
    // }

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

    if (nomeSetor == '') {
      return 'informe o setor';
    }

    String data;
    if (!alterando) {
      DateTime d = DateTime(dt3.year, dt3.month + 1, dt3.day);
      data = DateFormat('dd/MM/yyyy').format(d);
    } else {
      data = DateFormat('dd/MM/yyyy').format(dt3);
    }

    var extintorResquestModel = ExtintorRequestModel(
      id: id,
      nome: nome.text,
      validadeCasco: DateFormat('dd/MM/yyyy').parse(validadeCasco.text),
      validadeExtintor: DateFormat('dd/MM/yyyy').parse(validadeExtintor.text),
      proximaManutencao: DateFormat('dd/MM/yyyy').parse(data),
      tamanho: int.parse(selectedTamanho.replaceAll(RegExp(r'[^0-9]'), '')),
      tipo: selectedTipo,
      ativo: isAtivo,
      setor_id: idSetor,
      descricao: "Teste",
    );

    int res = 0;

    if (id > 0) {
      res = await _authService.updateExtintor(extintorResquestModel);

    } else {
      res = await _authService.insertExtintor(extintorResquestModel);
    }

    return res > 0 ? 'Extintor-$res' : 'Algo deu Errado';
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

  Future<void> goToPrintOutQrCode(String result, String tipo, String nome, String tipoExtintor) async {
    Map<String, dynamic> dados = {
      "result": result,
      "tipo": tipo,
      "nome": nome,
      "tipoExtintor": tipoExtintor,
    };
    await Get.toNamed(Routes.qrCodePrinter, arguments: dados);
  }
}
