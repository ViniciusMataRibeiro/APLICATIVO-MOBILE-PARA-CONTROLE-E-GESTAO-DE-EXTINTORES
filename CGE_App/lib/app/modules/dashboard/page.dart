import 'package:cge_app/app/data/services/auth/service.dart';
import 'package:cge_app/app/modules/extintores/page.dart';
import 'package:cge_app/app/modules/setores/page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../perfil/page.dart';
import '../perfil_tecnico/page.dart';
import 'controller.dart';

class DashboardPage extends GetView<DashboardController> {
  AuthService aux = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    final Items = <Widget>[
      const Icon(Icons.home, size: 30, color: Colors.white),
      const Icon(Icons.shop, size: 30, color: Colors.white),
      const Icon(Icons.messenger_sharp, size: 30, color: Colors.white),
      const Icon(Icons.person, size: 30, color: Colors.white),
    ];
    var obj = aux.user.value;
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            onTap: controller.changePage,
            height: 60,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 190, 0, 0),
            index: controller.currentPage.value,
            items: Items,
          ),
        ),
        extendBody: true,
        body: Obx(
          () => IndexedStack(
            index: controller.currentPage.value,
            children: [
              Setor(),
              Extintor(),
              if (obj!.tipo == 'empresas') ...[
                PerfilPage(),
              ] else ...[
                PerfilTecnicoPage(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
