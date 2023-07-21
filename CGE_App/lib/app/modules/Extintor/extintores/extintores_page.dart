import 'package:faker/faker.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/app_theme.dart';
import '../../../data/services/auth/service.dart';
import 'extintores_controller.dart';
import 'dart:ui' as ui;

DateTime selectedDate = DateTime.now();
String updatedDt = DateFormat("dd/MM/y").format(selectedDate);
String updatedDt2 = DateFormat("y-MM-dd").format(selectedDate);
List dados = [];

class Extintor extends GetView<ExtintorController> {
  const Extintor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ExtintorState(
            title: '',
          )),
    );
  }
}

class ExtintorState extends StatefulWidget {
  const ExtintorState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ExtintorPage createState() => ExtintorPage();
}

class ExtintorPage extends State<ExtintorState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  ExtintorController controller = Get.put(
    ExtintorController(),
  );
  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future mapa;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        cancelText: "CANCELAR",
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  primaryColor: const Color(0xFF4C131A),
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  colorScheme: const ColorScheme.light(
                          primary: Color.fromARGB(255, 190, 0, 0))
                      .copyWith(secondary: const Color(0xFF4C131A))),
              child: child!,
            ));
    if (picked != null && picked != selectedDate) {
      setState(
        () {
          _refresh(data: picked);
        },
      );
    }
  }

  _refresh({DateTime? data}) async {
    try {
      data ??= DateTime.parse(updatedDt2);

      setState(() {
        selectedDate = data!;
        updatedDt = DateFormat("dd/MM/y").format(data);
        updatedDt2 = DateFormat("y-MM-dd").format(data);
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    mapa = controller.getAllExtintor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var obj = aux.user.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/image/cge.png',
                      fit: BoxFit.contain,
                      height: 45,
                    ),
                    const SizedBox(width: 60),
                    Text(
                      textAlign: TextAlign.center,
                      updatedDt,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notification_important, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () => _refresh(),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 190, 0, 0),
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
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.check_circle_outline,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadTecnico');
                },
              ),
            ] else ...[
              Bubble(
                title: "Cadastrar Extintor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.add_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadExtintor');
                },
              ),
              Bubble(
                title: "Realizar Vistoria",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
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
          backGroundColor: const Color.fromARGB(255, 190, 0, 0),
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
            Future.delayed(
              const Duration(minutes: 1),
              () {
                if (mounted) {
                  _refresh();
                }
              },
            );
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/LogOut.png'),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: _mostradados(dados: dados),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/LogOut.png'),
                      fit: BoxFit.cover),
                ),
                child: const Center(
                  child: Text('Nenhum dado encontrado'),
                ),
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
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/LogOut.png'),
                fit: BoxFit.cover),
          ),
          child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 0),
                      Text(
                        dados[index]['nome'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: IconButton(
                          icon: const Icon(Icons.edit,
                              size: 25, color: Colors.black),
                          onPressed: () => controller.gotoEditExtintor(item),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipo de Extintor: ${item['tipoExtintor']}',
                        ),
                        Text(
                          'Validade do Casco: ${item['validadeCasco']}',
                        ),
                        Text(
                          'Próxima Manutenção: ${item['proximaManutencao']}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
