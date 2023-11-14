import 'package:cge_app/app/modules/Extintor/extintores/extintores_page.dart';
import 'package:cge_app/app/modules/Setor/setores/setores_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cge_app/app/data/services/auth/service.dart';
import 'package:cge_app/app/modules/Admin/admin_page.dart';
import '../Empresa/perfil_empresa/perfilEmpresa_page.dart';
import '../Tecnico/perfil_tecnico/perfilTecnico_page.dart';
import '../../Icones/icones_personalizado.dart';
import 'package:flutter/material.dart';
import 'dashboard_Controller.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class DashboardPage extends GetView<DashboardController> {
  AuthService aux = Get.find<AuthService>();

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Items = <Widget>[
      const Icon(Icones_Personalizado.place, size: 30, color: Colors.white),
      const Icon(Icones_Personalizado.fire_extinguisher,
          size: 30, color: Colors.white),
      const Icon(Icons.account_circle_rounded, size: 30, color: Colors.white),
    ];
    var obj = aux.user.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            onTap: controller.changePage,
            height: 50,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 116, 7, 7),
            index: controller.currentPage.value,
            items: Items,
          ),
        ),
        //extendBody: true,
        body: Obx(
          () => IndexedStack(
            index: controller.currentPage.value,
            children: [
              const Setor(),
              const Extintor(),
              if (obj!.tipo == 'empresa') ...[
                PerfilPage(),
              ] else ...[
                if (obj.tipo == 'admin') ...[
                  AdminPage(),
                ] else ...[
                  PerfilTecnicoPage(),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
