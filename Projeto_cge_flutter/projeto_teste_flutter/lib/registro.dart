import 'package:flutter/material.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registro de Empresa'),
        backgroundColor: const Color.fromARGB(255, 175, 31, 21),
      ),
    );
  }
}