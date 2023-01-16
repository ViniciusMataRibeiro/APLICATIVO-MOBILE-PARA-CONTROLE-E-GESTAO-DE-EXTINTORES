import 'package:app_cge/app/modules/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 31, 21),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/login.jpeg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Center(
                child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 50),
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
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      labelText: 'E-mail',
                      prefixIcon:
                          Icon(Icons.login_rounded, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                padding: const EdgeInsets.all(8),
                child: Obx(() => TextFormField(
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      obscureText: controller.showPassword.value,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        )),
                        labelText: 'Senha',
                        prefixIcon:
                            const Icon(Icons.lock_rounded, color: Colors.white),
                        suffixIcon: GestureDetector(
                          child: Icon(
                              controller.showPassword.value == false
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: Colors.white),
                          onTap: () {
                            controller.toggleShowPassword();
                          },
                        ),
                      ),
                    )),
              ),
              Center(
                child: Container(
                  alignment: const Alignment(0.6, 1.0),
                  child: const Text(
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      'Esqueceu sua senha?'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 175, 31, 21),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                    child: const Text('Entrar',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
