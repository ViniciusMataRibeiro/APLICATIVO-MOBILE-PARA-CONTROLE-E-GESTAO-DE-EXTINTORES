// ignore_for_file: file_names
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'enderecoEmpresa_controller.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class EnderecoEmpresaPage extends GetView<EnderecoEmpresaController> {
  const EnderecoEmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: EnderecoEmpresaState(
          title: '',
        ),
      ),
    );
  }
}

class EnderecoEmpresaState extends StatefulWidget {
  const EnderecoEmpresaState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  EnderecoEmpresa createState() => EnderecoEmpresa();
}

class EnderecoEmpresa extends State<EnderecoEmpresaState> {
  final EnderecoEmpresaController controller = Get.put(
    EnderecoEmpresaController(),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
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
                    width: size.width * 0.08,
                    height: 40,
                  ),
                  const Text(
                    'Endereço Empresa',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        centerTitle: true,
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
                  margin: const EdgeInsets.only(top: 20, bottom: 30),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/login.png'),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 0),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 20),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Editar Endereço",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          height: 2,
                          color: Colors.grey,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 7.0),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.cep,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'CEP',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.bairro,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Bairro',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.rua,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Rua',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.cidade,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Cidade',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 35, right: 35, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.uf,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'UF',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.numero,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Número',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 35, right: 35, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.referencia,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Ponto de Referência',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5, left: 35, right: 35, bottom: 15),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                var result = await controller.goToInsert();
                                if (result == 'true') {
                                  controller.toast('Registrado com sucesso');
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
                                'Gravar',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
