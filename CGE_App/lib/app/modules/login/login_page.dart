import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode field1FocusNode = FocusNode();
    var size = MediaQuery.of(context).size;
    if (controller.isLogged) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/dashboard');
      });
    }
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/login.jpeg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Center(
                child: Container(
                  height: 170,
                  width: 170,
                  margin: const EdgeInsets.only(top: 50),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/cge.png'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                        ),
                      ]),
                ),
              ),
              SizedBox(height: size.height * 0.15),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(8),
                child: Form(
                  child: TextFormField(
                    controller: controller.emailController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(field1FocusNode);
                    },
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontStyle: FontStyle.italic,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 0.9),
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
                margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                padding: const EdgeInsets.all(8),
                child: Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    focusNode: field1FocusNode,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    obscureText: controller.showPassword.value,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontStyle: FontStyle.italic,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 0.9),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
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
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 70, right: 70),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await controller.goTologin();
                    if (result != 'true') {
                      final snackBar = SnackBar(
                        elevation: 1,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Erro ao Logar!',
                          message: result.toString(),
                          contentType: ContentType.failure,
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      controller.toast('Logado com Sucesso!');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(60, 50),
                    maximumSize: const Size(70, 60),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      side: BorderSide(width: 1, color: Colors.white),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 116, 7, 7),
                        fontWeight: FontWeight.bold),
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
