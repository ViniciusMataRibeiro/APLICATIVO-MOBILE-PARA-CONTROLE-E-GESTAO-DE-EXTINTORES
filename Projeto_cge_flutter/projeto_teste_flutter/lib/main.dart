import 'package:flutter/material.dart';
import 'package:projeto_teste_flutter/registro_tecnico.dart';
import 'registro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistroTecnico(),
    );
  }
}
