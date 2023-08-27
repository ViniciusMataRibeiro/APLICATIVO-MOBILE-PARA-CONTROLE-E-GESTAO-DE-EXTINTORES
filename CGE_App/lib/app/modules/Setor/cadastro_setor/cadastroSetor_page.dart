// ignore_for_file: file_names

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import '../../../Icones/icones_personalizado.dart';
import '../../qrCode/print_out_qrcode/print.dart';
import 'cadastroSetor_controller.dart';

class CadastroSetorPage extends GetView<CadastroSetorController> {
  const CadastroSetorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: CadastroSetorState(
          title: '',
        ),
      ),
    );
  }
}

class CadastroSetorState extends StatefulWidget {
  const CadastroSetorState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  CadastroSetor createState() => CadastroSetor();
}

class CadastroSetor extends State<CadastroSetorState> {
  final CadastroSetorController controller = Get.put(CadastroSetorController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: size.width * 0.1,
                    height: 40,
                  ),
                  Text(
                    controller.alterando ? 'Editar Setor' : 'Cadastrar Setor',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/LogOut.png'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Center(
                child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 40, bottom: 40),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/cge.png'),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Form(
                        child: TextFormField(
                          controller: controller.name,
                          style: const TextStyle(
                              color: Colors.black, fontStyle: FontStyle.italic),
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icones_Personalizado.place,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                            labelText: 'Nome Setor',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Form(
                        child: TextFormField(
                          controller: controller.descricao,
                          style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.9),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            labelText: 'Descrição',
                            alignLabelWithHint: true,
                          ),
                          maxLines: 6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            var result = await controller.goToInsert();
                            if (result != 'Algo deu Errado') {
                              // ignore: use_build_context_synchronously
                              await _showMyDialog(result);
                            } else {
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Alerta',
                                  message: result.toString(),
                                  contentType: ContentType.failure,
                                ),
                              );
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 116, 7, 7),
                            fixedSize: const Size(250, 50),
                          ),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto-BoldItalic',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja imprimir o QRCode referente ao Setor?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Imprimir'),
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrintQrCode(
                      data: result,
                      tipo: 'Setor',
                      nome: controller.name.text,
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
