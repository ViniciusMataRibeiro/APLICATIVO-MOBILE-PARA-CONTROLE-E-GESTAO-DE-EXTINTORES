// ignore_for_file: unused_field
import '../../../Icones/icones_personalizado.dart';
import '../../../data/services/auth/service.dart';
import 'consulta_vistoria_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

List dados = [];

class ConsultaVistoria extends GetView<ConsultaVistoriaController> {
  const ConsultaVistoria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ConsultaVistoriaState(
            title: '',
          )),
    );
  }
}

class ConsultaVistoriaState extends StatefulWidget {
  const ConsultaVistoriaState({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  ConsultaVistoriaPage createState() => ConsultaVistoriaPage();
}

class ConsultaVistoriaPage extends State<ConsultaVistoriaState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  ConsultaVistoriaController controller = Get.put(
    ConsultaVistoriaController(),
  );

  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future mapa;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    mapa = controller.getAllManutencao();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                    width: size.width * 0.2,
                    height: 40,
                  ),
                  const Text(
                    'Vistorias',
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
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(25),
        //     bottomRight: Radius.circular(25),
        //   ),
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
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
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/image/modal.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            item['numeroExtintor'],
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
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.speed_outlined,
                              color: Colors.black, size: 30),
                          title: const Text(
                            'Manômetro',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: item['manometro']
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: item['manometro']
                                    ? null
                                    : Border.all(color: Colors.black, width: 1),
                              ),
                              width: 20,
                              height: 20,
                              child: item['manometro']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.fire_extinguisher_outlined,
                              color: Colors.black, size: 30),
                          title: const Text(
                            'Sinalização Parede',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: item['sinalizacaoParede']
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: item['sinalizacaoParede']
                                    ? null
                                    : Border.all(color: Colors.black, width: 1),
                              ),
                              width: 20,
                              height: 20,
                              child: item['sinalizacaoParede']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Ionicons.footsteps_outline,
                              color: Colors.black, size: 30),
                          title: const Text(
                            'Sinalização Piso',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: item['sinalizacaoPiso']
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: item['sinalizacaoPiso']
                                    ? null
                                    : Border.all(color: Colors.black, width: 1),
                              ),
                              width: 20,
                              height: 20,
                              child: item['sinalizacaoPiso']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Ionicons.enter_outline,
                              color: Colors.black, size: 30),
                          title: const Text(
                            'Acesso',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: item['acesso']
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: item['acesso']
                                    ? null
                                    : Border.all(color: Colors.black, width: 1),
                              ),
                              width: 20,
                              height: 20,
                              child: item['acesso']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: size.width * 0.09,
                            height: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/image/icon_mangueira.png'),
                                fit: BoxFit
                                    .contain, // Ajuste da imagem dentro do contêiner
                              ),
                            ),
                          ),
                          title: const Text(
                            'Mangueira',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: item['mangueira']
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: item['mangueira']
                                    ? null
                                    : Border.all(color: Colors.black, width: 1),
                              ),
                              width: 20,
                              height: 20,
                              child: item['mangueira']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: size.width * 0.09,
                            height: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/image/icon_lacre.png'),
                                fit: BoxFit
                                    .contain, // Ajuste da imagem dentro do contêiner
                              ),
                            ),
                          ),
                          title: const Text(
                            'Lacre',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: GestureDetector(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: item['lacre']
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: item['lacre']
                                    ? null
                                    : Border.all(color: Colors.black, width: 1),
                              ),
                              width: 20,
                              height: 20,
                              child: item['lacre']
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            height: 360,
            child: Stack(
              children: [
                Card(
                  elevation: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/image/modal_vistoria.png'),
                        fit: BoxFit.cover,
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(item['dataManutencao']),
                                  ),
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
                              vertical: 0, horizontal: 15),
                        ),
                        //SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, left: size.width * 0.05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(width: size.width * 0.08),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.width * 0.01),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icones_Personalizado.fire_extinguisher,
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
                                            'Número Extintor',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            item['numeroExtintor'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.location_on_sharp,
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
                                            'Setor',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            item['setor'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.engineering,
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
                                            'Técnico Responsavel',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            item['tecnico'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
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
                                                  item['dataManutencao']),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.check_outlined,
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
                                            'Apto para uso',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          item['manometro'] &&
                                                  item['sinalizacaoParede'] &&
                                                  item['sinalizacaoPiso'] &&
                                                  item['acesso'] &&
                                                  item['mangueira'] &&
                                                  item['lacre']
                                              ? const Text(
                                                  'Sim',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const Text(
                                                  'Não',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        item['manometro'] &&
                                item['sinalizacaoParede'] &&
                                item['sinalizacaoPiso'] &&
                                item['acesso'] &&
                                item['mangueira'] &&
                                item['lacre']
                            ? Container(
                                height: 3,
                                color: Colors.green,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 17, horizontal: 15),
                              )
                            : Container(
                                height: 3,
                                color: Colors.red,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 17, horizontal: 15),
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
