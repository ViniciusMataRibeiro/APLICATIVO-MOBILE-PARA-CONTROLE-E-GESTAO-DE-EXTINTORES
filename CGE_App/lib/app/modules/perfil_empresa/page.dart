import 'package:cge_app/app/modules/perfil_empresa/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PerfilEmpresaPage extends GetView<PerfilEmpresaController> {
  const PerfilEmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
        body: Center(
            child: Container(
              decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/image/registro.jpeg'),
              fit: BoxFit.cover)),
            child: ListView(
              children: [
                Center(
                  child: Container(
                    width: 400,
                    height: 220,
                    margin: const EdgeInsetsDirectional.only(top: 0, bottom: 0),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
        ),
      )
    );
  }
}