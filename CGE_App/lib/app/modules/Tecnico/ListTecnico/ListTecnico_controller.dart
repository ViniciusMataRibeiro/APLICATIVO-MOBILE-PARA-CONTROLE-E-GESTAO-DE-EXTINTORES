// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/services/auth/service.dart';
import 'package:cge_app/app/routes/routes.dart';
import 'package:get/get.dart';


class ListTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();

  bool get isAtivo => true;


  Future<Map> getTecnico() async {
    Map t = await _authService.getTecnico();

    return t;
  }

  Future<void> gotoEditTecnico(Map item) async {
    await Get.toNamed(Routes.cadTecnico, arguments: item);
  }

  Future<void> gotoDeleteTecnico(int idTecnico) async {
    await _authService.deleteTecnico(idTecnico);
  }

  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
