import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  _Resgitro createState() => _Resgitro();
}

class _Resgitro extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Registro de Empresa'),
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          leading: const Icon(Icons.arrow_back),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            width: 300,
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color:  Color.fromARGB(80, 0, 0, 0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                TextField(
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    icon: Icon(Icons.view_agenda_outlined),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.message_outlined)
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.verified_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}