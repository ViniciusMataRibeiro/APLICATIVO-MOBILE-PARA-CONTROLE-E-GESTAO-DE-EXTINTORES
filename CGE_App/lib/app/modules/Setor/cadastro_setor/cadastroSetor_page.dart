// ignore_for_file: file_names
import '../../../Icones/icones_personalizado.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'cadastroSetor_controller.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

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

class CadastroSetor extends State<CadastroSetorState>{

  final CadastroSetorController controller = Get.put(CadastroSetorController());
  final GlobalKey<FormState> validar = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FocusNode field1FocusNode = FocusNode();
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
                      image: AssetImage('assets/image/login.png'),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 190, 189, 189),
                          blurRadius: 1,
                          offset: Offset(1, 0)),
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
                        key: validar,
                        child: TextFormField(
                          controller: controller.name,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo é obrigatorio';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(field1FocusNode);
                          },
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
                          textInputAction: TextInputAction.done,
                          focusNode: field1FocusNode,
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
                            validar.currentState?.validate();
                            var result = await controller.goToInsert();
                            if (result != 'Algo deu Errado') {
                              controller.toast('Cadastrado com sucesso');
                              Get.offAllNamed('/dashboard');
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
}
