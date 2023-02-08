import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth/service.dart';
import '../perfil/controller.dart';

String nome = "";

class PerfilTecnicoPage extends GetView<PerfilController> {
  AuthService aux = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    var obj = aux.user.value;
    var nome = obj!.nome;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/registro.jpeg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4C131A),
                      Color.fromARGB(255, 175, 31, 21),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.person_pin,
                          size: 150, color: Colors.white),
                      Text(
                        nome,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Card(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    color: const Color(0xFFD7CCC8),
                    elevation: 5,
                    child: ListTile(
                      title: const Text(
                        "Opção 1",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: const Icon(Icons.accessibility_new_rounded, size: 40),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    color: const Color(0xFFD7CCC8),
                    elevation: 5,
                    child: ListTile(
                      title: const Text(
                        "Opção 2",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: const Icon(Icons.accessible_forward_sharp, size: 40),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    color: const Color(0xFFD7CCC8),
                    elevation: 5,
                    child: ListTile(
                      title: const Text(
                        "Opção 3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: const Icon(Icons.add_reaction, size: 40),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    color: const Color(0xFFD7CCC8),
                    elevation: 5,
                    child: ListTile(
                      title: const Text(
                        "Opção 4",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: const Icon(Icons.add_shopping_cart_rounded, size: 40),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
