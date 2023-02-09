import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cadastroSetor_controller.dart';

class CadastroSetorPage extends GetView<CadastroSetorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Cadastro de Setor',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 190, 0, 0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/registro.jpeg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(top: 100, left: 50, right: 50),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Form(
                        child: TextFormField(
                          style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18,
                              color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.9),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Nome',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Form(
                        child: TextFormField(
                          style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18,
                              color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.9),
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
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Descrição',
                            alignLabelWithHint: true,
                          ),
                          maxLines: 7,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(200, 50)),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto-BoldItalic',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
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
