import 'package:faker/faker.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/app_theme.dart';
import '../../../data/services/auth/service.dart';
import 'dart:ui' as ui;

import 'extintores_details_controller.dart';

DateTime selectedDate = DateTime.now();
String updatedDt = DateFormat("dd/MM/y").format(selectedDate);
String updatedDt2 = DateFormat("y-MM-dd").format(selectedDate);
List dados = [];

class ExtintorDetails extends GetView<ExtintorDetailsController> {
  const ExtintorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ExtintorDetailsState(
            title: '',
          )),
    );
  }
}

class ExtintorDetailsState extends StatefulWidget {
  const ExtintorDetailsState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ExtintorDetailsPage createState() => ExtintorDetailsPage();
}

class ExtintorDetailsPage extends State<ExtintorDetailsState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  ExtintorDetailsController controller = Get.put(
    ExtintorDetailsController(),
  );

  String obterImagem(String tipoExtintor) {
    switch (tipoExtintor) {
      case 'Tipo A':
        return 'assets/image/ExtintorClassesA.png';
      case 'Tipo B':
        return 'assets/image/ExtintorClassesB.png';
      case 'Tipo ABC':
        return 'assets/image/ExtintorClassesABC.png';
      case 'Tipo AB':
        return 'assets/image/ExtintorClassesAB.png';
      case 'Tipo BC':
        return 'assets/image/ExtintorClassesBC.png';
      case 'Tipo C':
        return 'assets/image/ExtintorClassesC.png';
      case 'Tipo D':
        return 'assets/image/ExtintorClassesD.png';
      case 'Tipo K':
        return 'assets/image/ExtintorClassesK.png';
      default:
        return 'Imagem não encontrada';
    }
  }

  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future mapa;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    mapa = controller.getExtintor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var obj = aux.user.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.offAllNamed('/dashboard');
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: size.width * 0.05,
                    height: 40,
                  ),
                  const Text(
                    'Detalhes do Extintor',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: FloatingActionBubble(
          herotag: UniqueKey(),
          items: <Bubble>[
            if (obj!.tipo == 'empresa') ...[
              Bubble(
                title: "Cadastrar Tecnico",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.add_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadTecnico');
                },
              ),
            ] else ...[
              Bubble(
                title: "Cadastrar Extintor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.add_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadExtintor');
                },
              ),
              Bubble(
                title: "Realizar Vistoria",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.check_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/vistoria');
                },
              ),
            ],
          ],
          animation: _animation,
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
          iconColor: Colors.white,
          iconData: Icons.handyman_outlined,
          backGroundColor: const Color.fromARGB(255, 116, 7, 7),
        ),
      ),
      body: buildContainer(),
    );
  }

  buildContainer() {
    return FutureBuilder(
      future: mapa,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dados = temp['dados'];
          if (dados.isNotEmpty) {
            return Scaffold(
              body: Center(
                child: _mostradados(dados: dados),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Nenhum dado encontrado'),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _mostradados({required List dados}) {
    return ListView.builder(
      itemCount: dados.length,
      padding: const EdgeInsets.only(bottom: 52, top: 50),
      itemBuilder: (BuildContext context, index) {
        Map item = dados[index];
        return GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/image/LogOut.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 25),
                            Text(
                              'Dados Extintor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/image/LogOut.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 25),
                            Text(
                              'Dados Extintor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/image/LogOut.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 25),
                            Text(
                              'Dados Extintor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
