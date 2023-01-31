import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../abas/page.dart';
import '../perfil/page.dart';
import 'controller.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    final Items = <Widget>[
      const Icon(
        Icons.view_stream_rounded,
        size: 40,
        color: Colors.white,
      ),
      const Icon(
        Icons.person,
        size: 40,
        color: Colors.white,
      ),
    ];

    return Scaffold(
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            onTap: controller.changePage,
            animationCurve: Curves.easeInOut,
            height: 60,
            index: controller.currentPage.value,
            color: const Color.fromARGB(255, 190, 0, 0),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            items: Items,
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
