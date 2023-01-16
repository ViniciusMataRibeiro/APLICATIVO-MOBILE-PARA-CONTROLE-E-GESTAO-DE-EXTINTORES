import 'package:app_cge/app/modules/abas/page.dart';
import 'package:app_cge/app/modules/dashboard/controller.dart';
import 'package:app_cge/app/modules/perfil/page.dart';
import 'package:app_cge/app/modules/setores/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            onDestinationSelected: controller.changePage,
            height: 60,
            selectedIndex: controller.currentPage.value,
            backgroundColor: const Color.fromARGB(255, 247, 20, 3),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.view_stream,
                  color: Colors.white,
                ),
                label: 'Setores',
                selectedIcon: Icon(Icons.view_stream_rounded),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                ),
                label: 'Perfil',
                selectedIcon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: Obx(() => IndexedStack(
              index: controller.currentPage.value,
              children: [
                AbaPage(),
                PerfilPage(),
              ],
            )));
  }
}
