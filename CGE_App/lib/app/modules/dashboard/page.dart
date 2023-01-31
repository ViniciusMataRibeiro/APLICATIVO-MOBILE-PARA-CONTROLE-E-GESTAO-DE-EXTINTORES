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
      const Icon(Icons.view_stream_rounded, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            onTap: controller.changePage,
            height: 60,
            index: controller.currentPage.value,
            color: Colors.red,
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
