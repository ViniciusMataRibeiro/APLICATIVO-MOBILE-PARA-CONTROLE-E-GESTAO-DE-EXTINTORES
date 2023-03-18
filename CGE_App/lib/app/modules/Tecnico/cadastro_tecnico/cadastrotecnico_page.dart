import 'package:cge_app/app/core/app_theme.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:ui' as ui;

import 'cadastrotecnico_controller.dart';

class CadastroTecnicoPage extends GetView<CadastroTecnicoController> {
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
                Get.offAllNamed('/dashboard');
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  'assets/image/cge.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Cadastro Tecnico',
              style: TextStyle(
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
                image: AssetImage('assets/image/registro.jpeg'),
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
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Form(
                        child: TextFormField(
                          controller: cadastroTecnicoController.name,
                          style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18,
                              color: Colors.white),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.verified_user,
                              color: Colors.white,
                              size: 27,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            labelText: 'Nome',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Form(
                        child: TextFormField(
                          controller: cadastroTecnicoController.email,
                          style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18,
                              color: Colors.white),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            icon: Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 27,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Obx(
                        () => TextFormField(
                          controller: cadastroTecnicoController.password,
                          style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18,
                              color: Colors.white),
                          obscureText: cadastroTecnicoController.showPassword.value,
                          decoration:  InputDecoration(
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.lock_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            labelText: 'Senha',
                            suffixIcon: GestureDetector(
                          child: Icon(
                              cadastroTecnicoController.showPassword.value == false
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: Colors.white),
                          onTap: () {
                            cadastroTecnicoController.toggleShowPassword();
                          },
                        ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            cadastroTecnicoController.goToInsert();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 175, 31, 21),
                            fixedSize: const Size(300, 50),
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
