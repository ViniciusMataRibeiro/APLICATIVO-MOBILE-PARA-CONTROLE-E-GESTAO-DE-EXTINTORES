import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import '../../../core/app_theme.dart';
import '../../../data/services/auth/service.dart';
import 'ListTecnico_controller.dart';

class ListTecnico extends GetView<ListTecnicoController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ListTecnicoState(
            title: '',
          )),
    );
  }
}

class ListTecnicoState extends StatefulWidget {
  const ListTecnicoState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ListTecnicoPage createState() => ListTecnicoPage();
}

class ListTecnicoPage extends State<ListTecnicoState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  final ListTecnicoController controller = Get.put(ListTecnicoController());
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future dadosTecnico;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    dadosTecnico = controller.getTecnico();

  }

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  buildContainer() {
    var obj = aux.user.value;
    return FutureBuilder(
      future: dadosTecnico,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 175, 31, 21),
              title: Row(
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
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/image/cge.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'Tecnicos',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: _mostraDados(dados: snapshot.data),
          );
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

  _mostraDados({required dados}) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/registro.jpeg'), fit: BoxFit.cover),
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          //Map item = dados[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                color: Colors.grey,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    _icone(),
                    _detalhes(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _icone() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 68, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Visibility(
              visible: false,
              child: IconButton(
                icon: Icon(Icons.edit, size: 25, color: Colors.white),
                onPressed: null,
              ),
            ),
            const Flexible(
              flex: 5,
              child: Icon(
                Icons.person,
                size: 40,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Flexible(
              flex: 5,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 25, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 0),
        child: Text(
          'Nome',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    ],
  );
}

Widget _detalhes() {
  return const Card(
    color: Color(0xFFE8E8E8),
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'Sem informação',
                        style: TextStyle(
                          color: Color.fromARGB(255, 122, 0, 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quantidade de Vistorias",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'Sem informação',
                        style: TextStyle(
                          color: Color.fromARGB(255, 122, 0, 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'Sem informação',
                        style: TextStyle(
                          color: Color.fromARGB(255, 122, 0, 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
