// ignore_for_file: file_names
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'cadastroEmpresa_controller.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class CadastroEmpresaPage extends GetView<CadastroEmpresaController> {
  const CadastroEmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: CadastroEmpresaState(
          title: '',
        ),
      ),
    );
  }
}

class CadastroEmpresaState extends StatefulWidget {
  const CadastroEmpresaState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  CadastroEmpresa createState() => CadastroEmpresa();
}

class CadastroEmpresa extends State<CadastroEmpresaState> {
  final CadastroEmpresaController controller =
      Get.put(CadastroEmpresaController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 31, 21),
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.offAllNamed('/perfiladmin');
              },
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: size.width * 0.05,
              height: 40,
            ),
            Text(
              controller.alterando ? 'Editar Empresa' : 'Cadastro Empresa',
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/LogOut.png'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Center(
                  child: Container(
                height: 140,
                width: 140,
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/cge.png'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ]),
              )),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 50, left: 40, right: 40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 0, top: 8),
                      padding: const EdgeInsets.only(bottom: 0),
                    ),
                    Form(
                      child: TextFormField(
                        controller: controller.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          labelText: 'Nome',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Form(
                      child: TextFormField(
                        controller: controller.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Form(
                        child: TextFormField(
                      controller: controller.password,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        labelText: 'Senha',
                      ),
                    )),
                    Form(
                        child: TextFormField(
                      controller: controller.telefone,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        labelText: 'Telefone',
                      ),
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(
                  bottom: 30,
                  left: 40,
                  right: 40,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Endereço',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Form(
                          child: TextFormField(
                        controller: controller.cidade,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          labelText: 'Cidade',
                        ),
                      )),
                      Form(
                          child: TextFormField(
                        controller: controller.cep,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          labelText: 'CEP',
                        ),
                      )),
                      Form(
                          child: TextFormField(
                        controller: controller.bairro,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          labelText: 'Bairro',
                        ),
                      )),
                      Form(
                          child: TextFormField(
                        controller: controller.rua,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          labelText: 'Rua',
                        ),
                      )),
                      Form(
                          child: TextFormField(
                        controller: controller.numero,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          labelText: 'Número',
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await controller.goToInsert();
                    if (result == 'true') {
                      controller.toast('Gravado com sucesso!');
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
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                  ),
                  child: const Text('Registrar',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
