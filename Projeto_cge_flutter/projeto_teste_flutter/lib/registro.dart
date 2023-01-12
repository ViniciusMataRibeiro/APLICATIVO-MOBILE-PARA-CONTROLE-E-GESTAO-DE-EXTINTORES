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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/registro.jpeg'),
                    fit: BoxFit.cover)),
            child: ListView(children: [
              Center(
                child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 25),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/cge.jpeg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(10, 10),
                        ),
                      ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 100, left: 50, right: 50),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Nome',
                        hintText: 'Ex: Empresa',
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.email_rounded),
                        labelText: 'E-mail',
                        hintText: 'Ex: empresa@email.com',
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock_rounded),
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.call_rounded),
                        labelText: 'Telefone',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                          onPressed: (() => {}),
                          child: const Text('Registrar')),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
