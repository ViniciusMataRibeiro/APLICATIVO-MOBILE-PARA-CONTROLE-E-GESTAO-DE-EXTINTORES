import 'package:app_cge/app/modules/cadastro_setor/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroSetorPage extends GetView<CadastroSetorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('CadastroSetorPage')),
        body: SafeArea(child: Text('CadastroSetorController')));
  }
}
