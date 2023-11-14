// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'cadastrotecnico_controller.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class CadastroTecnicoPage extends GetView<CadastroTecnicoController> {
  const CadastroTecnicoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: CadastroExtintorState(
          title: '',
        ),
      ),
    );
  }
}

class CadastroExtintorState extends StatefulWidget {
  const CadastroExtintorState({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  CadastroExtintor createState() => CadastroExtintor();
}

class CadastroExtintor extends State<CadastroExtintorState>
    with SingleTickerProviderStateMixin {
  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;
  CadastroTecnicoController cadastroTecnicoController =
      Get.put(CadastroTecnicoController());

  var mask = MaskTextInputFormatter(mask: "(##) #####-####");

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode _field1FocusNode = FocusNode();
    final FocusNode _field2FocusNode = FocusNode();
    // ignore: unused_local_variable
    bool isSelectbloqueado = cadastroTecnicoController.bloqueado.value;
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
                    width: size.width * 0.08,
                    height: 40,
                  ),
                  Text(
                    cadastroTecnicoController.alterandoTexto
                    ? '\t\tEditar Tecnico'
                    : 'Cadastrar Tecnico',
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
                        color: Colors.grey,
                        offset: Offset(1, 0),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 35,
                      ),
                      title: TextFormField(
                        controller: cadastroTecnicoController.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_field1FocusNode);
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                      title: TextFormField(
                        controller: cadastroTecnicoController.email,
                        textInputAction: TextInputAction.next,
                        focusNode: _field1FocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_field2FocusNode);
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.black,
                          size: 35,
                        ),
                        title: Obx(
                          () => TextFormField(
                            controller: cadastroTecnicoController.password,
                            textInputAction: TextInputAction.done,
                            focusNode: _field2FocusNode,
                            obscureText: cadastroTecnicoController.showPassword.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            var result =
                                await cadastroTecnicoController.goToInsert();
                            if (result == 'true') {
                              cadastroTecnicoController
                                  .toast('Registrado com sucesso');
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
}
