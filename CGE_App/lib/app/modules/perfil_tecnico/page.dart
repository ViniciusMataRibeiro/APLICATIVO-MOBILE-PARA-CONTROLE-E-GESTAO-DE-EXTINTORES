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
            ],
          ),
        ),
      ),
    );
  }
}
