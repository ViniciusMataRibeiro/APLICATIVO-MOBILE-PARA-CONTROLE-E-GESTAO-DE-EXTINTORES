// ignore_for_file: file_names, must_be_immutable
import 'package:cge_app/app/modules/Tecnico/perfil_tecnico/perfilTecnico_controller.dart';
import '../../../data/services/auth/service.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String nome = "";
class PerfilTecnicoPage extends GetView<PerfilTecnicoController> {
  AuthService aux = Get.find<AuthService>();

  PerfilTecnicoPage({super.key});

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
                height: MediaQuery.of(context).size.height / 2.7,
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
                      const SizedBox(height: 30),
                      const Icon(Icons.person_pin,
                          size: 150, color: Colors.white),
                      const SizedBox(height: 5),
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
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(
                    top: 40, left: 40, right: 40, bottom: 40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Ionicons.document_text_outline,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Consultar Vistoria",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.black),
                      onTap: () {
                        Get.offAllNamed('/consultaVistoria');
                      },
                    ),
                    const Divider(color: Colors.black, thickness: 1),
                    const SizedBox(height: 15),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        controller.goTologout();
                      },
                    ),
                    const Divider(color: Colors.black, thickness: 1),
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
