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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/registro.jpeg'),
              fit: BoxFit.cover)
          ),
          child: Column(
          children: [
            Center(
              child: Container(
                height: 140,
                width: 140,
                margin: const EdgeInsets.only(top: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/image/cge.jpeg'),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: Offset(10, 10),
                      ),
                  ]
                ),
              ),
            ),
          ]
        ),      
      ),
      ),
    );
  }
}