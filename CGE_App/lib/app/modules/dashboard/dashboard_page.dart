import 'package:cge_app/app/data/services/auth/service.dart';
import 'package:cge_app/app/modules/Extintor/extintores/extintores_page.dart';
import 'package:cge_app/app/modules/Setor/setores/setores_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Icones/icones_personalizado.dart';
import '../Empresa/perfil_empresa/perfilEmpresa_page.dart';
import '../Tecnico/perfil_tecnico/perfilTecnico_page.dart';
import 'dashboard_Controller.dart';

class DashboardPage extends GetView<DashboardController> {
  AuthService aux = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    final Items = <Widget>[
      const Icon(Icones_Personalizado.place, size: 30, color: Colors.white),
      const Icon(Icones_Personalizado.fire_extinguisher,
          size: 30, color: Colors.white),
      const Icon(Icons.account_circle_rounded, size: 30, color: Colors.white),
    ];
    var obj = aux.user.value;
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            onTap: controller.changePage,
            height: 50,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 190, 0, 0),
            index: controller.currentPage.value,
            items: Items,
          ),
        ),
        //extendBody: true,
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}
