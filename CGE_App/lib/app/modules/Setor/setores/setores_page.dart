import 'package:cge_app/app/core/app_theme.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../../data/services/auth/service.dart';
import '../../widget/gaficoSetor.dart';
import 'setores_controller.dart';

DateTime selectedDate = DateTime.now();
String updatedDt = DateFormat("dd/MM/y").format(selectedDate);
String updatedDt2 = DateFormat("y-MM-dd").format(selectedDate);
List dados = [];

class Setor extends GetView<SetorController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: SetorState(
          title: '',
        ),
      ),
    );
  }
}

class SetorState extends StatefulWidget {
  const SetorState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  SetorPage createState() => SetorPage();
}

class SetorPage extends State<SetorState> with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  SetorController controller = Get.put(
    SetorController(),
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
            primary: Color.fromARGB(255, 190, 0, 0),
          ).copyWith(
            secondary: const Color(0xFF4C131A),
          ),
        ),
        child: child!,
      ),
    );
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

    //mapa = controller.getResumoSetor();

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
            Image.asset(
              'assets/image/cge.png',
              fit: BoxFit.contain,
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                updatedDt,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notification_important, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.find_replace_outlined, color: Colors.white),
            onPressed: () => _refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
            onPressed: () => _selectDate(context),
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
                title: "Editar Setor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.edit_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadSetor');
                },
              ),
              Bubble(
                title: "Cadastrar Setor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.add_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadSetor');
                },
              ),
              Bubble(
                title: "Realizar Vistoria",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.check_circle_outline,
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
        if (snapshot.connectionState != ConnectionState.done) {
          if (dados.isNotEmpty) {
            return DefaultTabController(
              length: 1,
              child: _mostradados(tipo: 'Setor', dados: dados),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Nenhum dado encontrado'),
              ),
            );
          }
        } else if (snapshot.hasData) {
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

            return DefaultTabController(
              length: 1,
              child: Scaffold(
                appBar: AppBar(
                  leading: Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset("assets/img/frota_logo.png"),
                  ),
                  title: Text(updatedDt),
                  backgroundColor: const Color(0xFF4C131A),
                ),
                body: _mostradados(tipo: 'Setor', dados: dados),
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

  _mostradados({String? tipo, required List dados}) {
    return ListView.builder(
      itemCount: dados.length,
      itemBuilder: (BuildContext context, index) {
        Map item = dados[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Setor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB2505C),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50, bottom: 20),
                    child: Grafico(item),
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
