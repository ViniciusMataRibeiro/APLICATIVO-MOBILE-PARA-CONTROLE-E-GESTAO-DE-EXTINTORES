import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../../../core/app_theme.dart';
import 'consulta_vistoria_controller.dart';

class ConsultaVistoriaPage extends GetView<ConsultaVistoriaController> {
  const ConsultaVistoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: ConsultaVistoriaState(
          title: '',
        ),
      ),
    );
  }
}


class ConsultaVistoriaState extends StatefulWidget {
  const ConsultaVistoriaState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsultaVistoria createState() => ConsultaVistoria();
}

class ConsultaVistoria extends State<ConsultaVistoriaState>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}