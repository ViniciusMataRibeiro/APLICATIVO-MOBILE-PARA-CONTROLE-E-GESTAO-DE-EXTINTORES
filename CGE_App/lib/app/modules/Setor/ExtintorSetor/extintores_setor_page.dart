// ignore_for_file: unused_field
import '../../../Icones/icones_personalizado.dart';
import '../../../data/services/auth/service.dart';
import 'extintores_setor_controller.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

List dados = [];

class ExtintorSetor extends GetView<ExtintorSetorController> {
  const ExtintorSetor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ExtintorSetorState(
            title: '',
          )),
    );
  }
}

class ExtintorSetorState extends StatefulWidget {
  const ExtintorSetorState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ExtintorSetorPage createState() => ExtintorSetorPage();
}

class ExtintorSetorPage extends State<ExtintorSetorState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  ExtintorSetorController controller = Get.put(
    ExtintorSetorController(),
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
      case 'Tipo CO²':
        return 'assets/image/ExtintorClassesCO2.png';
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

    mapa = controller.getExtintorSetor(controller.idSetor);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
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
            Container(
              margin: EdgeInsets.only(right: size.width * 0.18),
              height: 40,
            ),
            Text(
              '${controller.nomeSetor}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        centerTitle: true,
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
                child: Text('Nenhum extintor cadastrado a esse setor'),
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
    var obj = aux.user.value;
    return ListView.builder(
      itemCount: dados.length,
      padding: const EdgeInsets.only(bottom: 52, top: 50),
      itemBuilder: (BuildContext context, index) {
        var size = MediaQuery.of(context).size;
        Map item = dados[index];
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 485,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/image/modal.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            item['nome'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(
                          color: Colors.black54,
                          thickness: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.engineering,
                                color: Colors.red, size: 35),
                            title: const Text(
                              'Ultima Vistoria',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: item['ultimaVistoria'] == null
                                ? const Text(
                                    'Sem dados',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )
                                : Text(
                                    DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(
                                        item['ultimaVistoria'],
                                      ),
                                    ),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range_outlined,
                                color: Colors.black54, size: 35),
                            title: const Text(
                              'Validade Extintor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateTime.parse(
                                  item['validadeExtintor'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range_outlined,
                                color: Colors.black54, size: 35),
                            title: const Text(
                              'Venc. Hidrostatico',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateTime.parse(
                                  item['validadeCasco'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                                Icones_Personalizado.fire_extinguisher,
                                color: Colors.black54,
                                size: 35),
                            title: const Text(
                              'Tipo Extintor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                                '${item['tipoExtintor']}\t${item['tamanho']} Kg'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.location_on_sharp,
                                color: Colors.black54, size: 35),
                            title: Text(
                              'Setor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text('Setor A'),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        obj!.tipo != 'empresa'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 116, 7, 7),
                                    ),
                                    onPressed: () =>
                                        {controller.gotoEditExtintor(item)},
                                    child: const Text(
                                      'Editar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                    child: const VerticalDivider(
                                      thickness: 2,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 116, 7, 7),
                                    ),
                                    onPressed: () async => {
                                      await controller
                                          .gotoDeleteExtintor(item['id'])
                                    },
                                    child: const Text(
                                      'Excluir',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Editar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                    child: const VerticalDivider(
                                      thickness: 2,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Excluir',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            height: 195,
            child: Stack(
              children: [
                Card(
                  elevation: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/image/card.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  dados[index]['nome'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          height: 2,
                          color: Colors.grey,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 7.0),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Image.asset(
                                    obterImagem(item['tipoExtintor']),
                                    height: size.height * 0.10,
                                    width: size.width * 0.17,
                                    fit: BoxFit.contain),
                              ),
                              SizedBox(width: size.width * 0.1),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.engineering,
                                        size: 38,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Ultima Vistoria',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          item['ultimaVistoria'] == null
                                              ? const Text(
                                                  'Sem dados',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                )
                                              : Text(
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(
                                                    DateTime.parse(
                                                      item['ultimaVistoria'],
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.date_range_outlined,
                                        size: 38,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Proxima Vistoria',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(
                                                  item['proximaManutencao']),
                                            ),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(height: 15),
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.end,
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.fire_extinguisher,
                                  //       size: 38,
                                  //       color: Colors.black,
                                  //     ),
                                  //     SizedBox(
                                  //       width: size.width * 0.03,
                                  //     ),
                                  //     const Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           'Tamanho',
                                  //           style: TextStyle(
                                  //             color: Colors.black,
                                  //             fontStyle: FontStyle.italic,
                                  //             fontSize: 15,
                                  //           ),
                                  //         ),
                                  //         Text(
                                  //           '4 ' + 'Kg',
                                  //           style: TextStyle(
                                  //             color: Colors.black54,
                                  //             fontSize: 15,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
