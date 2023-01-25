import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CadastroExtintorPage extends GetView<CadastroExtintorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    'assets/image/cge.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text('Cadastro de Extintor',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/registro.jpeg'),
                      fit: BoxFit.cover)),
              child: ListView(children: [
                Center(
                    child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 80),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/cge.jpeg'),
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
                  margin:
                      const EdgeInsets.only(bottom: 100, left: 50, right: 50),
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
                          child: Form(
                            child: Obx(() => DropdownButton(
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  value: controller.extintor,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    value = controller.extintor;
                                  },
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  items: [
                                            const DropdownMenuItem(
                                              child: Text('teste1'),
                                              value: 1,
                                            ),
                                          ].isEmpty ||
                                          controller.extintor == 0
                                      ? [
                                          const DropdownMenuItem(
                                            child: Text('Selecione'),
                                            value: 0,
                                          ),
                                        ]
                                      : [
                                          const DropdownMenuItem(
                                            child: Text('Selecione'),
                                            value: 0,
                                          ),
                                        ],
                                )),
                          )),
                      Container(
                        margin: const EdgeInsets.all(0),
                        child: Form(
                            child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Tamanho',
                          ),
                        )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(0),
                        child: Form(
                            child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Validade do Casco',
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }
}