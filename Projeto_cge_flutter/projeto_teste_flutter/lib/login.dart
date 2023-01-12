import 'package:flutter/material.dart';
import 'widget/blockButton.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/login.jpeg'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 80),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/cge.jpeg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                      ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 65, left: 25, right: 25),
                padding: const EdgeInsets.all(8),
                child: Form(
                  child: TextFormField(
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.supervised_user_circle),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                padding: const EdgeInsets.all(8),
                child: Form(
                  child: TextFormField(
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.verified),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  alignment: const Alignment(0.6, 1.0),
                  child: const Text(
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      'Esqueceu sua senha?'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BlockButton(
                icon: Icons.check,
                label: 'Entrar',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
