import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../perfil/controller.dart';

class PerfilTecnicoPage extends GetView<PerfilController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/registro.jpeg'),
              fit: BoxFit.cover)),
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 500,
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 190, 0, 0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.all(50),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image/cge.png'),
                                fit: BoxFit.fill),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                              ),
                            ]),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Tecnico',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  fixedSize: const Size(300, 80),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                icon: const Icon(
                  Icons.list_alt_rounded,
                  color: Colors.black,
                  size: 30,
                ),
                label: const Text(
                  'Consultar Vistorias',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              )),
          ElevatedButton(
            onPressed: () => Get.offAllNamed('/vistoria'),
            child: const Text('Vistoria')),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  fixedSize: const Size(300, 80),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 30,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              )),
        ],
      ),
    )));
  }
}
