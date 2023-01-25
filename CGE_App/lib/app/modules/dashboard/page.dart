import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../abas/page.dart';
import '../perfil/page.dart';
import 'controller.dart';

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
