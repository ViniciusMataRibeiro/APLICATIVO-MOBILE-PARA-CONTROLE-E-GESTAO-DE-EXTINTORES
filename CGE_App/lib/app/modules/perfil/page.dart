import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PerfilPage extends GetView<PerfilController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/registro.jpeg'),
              fit: BoxFit.cover)),
    )));
  }
}
