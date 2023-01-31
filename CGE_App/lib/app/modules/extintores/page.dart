import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ExtintorPage extends GetView<ExtintorController> {
  var letra = <String>[];
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 10; i++) {
      var char = faker.randomGenerator.fromCharSet('ABCK', 1);
      letra.add(char);
    }
    return Scaffold(
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/cadExtintor');
            },
            backgroundColor: const Color.fromARGB(255, 175, 31, 21),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            child: const Icon(Icons.add_rounded, size: 40, color: Colors.white),
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
              for (var i = 0; i < 10; i++) ...[
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                    surfaceTintColor: const Color.fromARGB(255, 201, 201, 201),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              'Extintor Nº ${faker.randomGenerator.integer(99)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 131, 30, 23),
                                  fontStyle: FontStyle.italic)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 20, color: Colors.green),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text('Data de Vencimento',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Color.fromARGB(255, 78, 78, 78),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 20, color: Colors.green),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text('Última Inspeção',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Color.fromARGB(255, 78, 78, 78),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 20, color: Colors.green),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text('Informações do Extintor',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Color.fromARGB(255, 78, 78, 78),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        child: Image.asset(
                                          'assets/image/Classe-${letra[i]}.jpg',
                                          fit: BoxFit.cover,
                                          height: 80,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        )));
  }
}
