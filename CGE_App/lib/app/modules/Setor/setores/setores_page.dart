import 'package:floating_action_bubble/floating_action_bubble.dart';
import '../../../data/services/auth/service.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'package:cge_app/app/routes/routes.dart';
import '../../widget/gaficoSetor.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'setores_controller.dart';
import 'dart:ui' as ui;

List dados = [];

class Setor extends GetView<SetorController> {
  const Setor({super.key});

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

  _refresh() async {
    try {
      setState(() {
        mapa = controller.getResumoSetor();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
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

    mapa = controller.getResumoSetor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Image.asset(
                    'assets/image/login.png',
                    fit: BoxFit.contain,
                    height: 45,
                  ),
                ],
              ),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () => Get.toNamed('/qrCodeScanner'),
          ),
          // IconButton(
          //   icon: const Icon(Icons.notification_important, color: Colors.white),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () => _refresh(),
          ),
        ],
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
                title: "Cadastrar Setor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.add_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadSetor');
                  //_modalSetor();
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
          dados = temp['dadosGraficos'];
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
          onTap: () async {
            await Get.toNamed(Routes.extintorSetor, arguments: item);
          },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 25),
                            Text(
                              '${item['setor']}',
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
                                onPressed: () => controller.gotoEditSetor(item),
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
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                              offset: Offset(0, 5),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/image/LogOut.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ExportCircular(item),
                      ),
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
  // _modalSetor() {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       var size = MediaQuery.of(context).size;
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         content: Container(
  //           padding: const EdgeInsets.all(10.0),
  //           height: 430,
  //           decoration: BoxDecoration(
  //               image: const DecorationImage(
  //                 image: AssetImage('assets/image/modal.png'),
  //                 fit: BoxFit.fill,
  //               ),
  //               borderRadius: BorderRadius.circular(10)),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   'Cadastrar Setor',
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       fontStyle: FontStyle.italic,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               const Divider(
  //                 color: Colors.black54,
  //                 thickness: 2,
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(
  //                     left: size.width * 0.05, right: size.width * 0.05),
  //                 child: Form(
  //                   child: TextFormField(
  //                     //controller: controller.name,
  //                     style: const TextStyle(
  //                         color: Colors.black, fontStyle: FontStyle.italic),
  //                     decoration: InputDecoration(
  //                       prefixIcon: Padding(
  //                         padding: EdgeInsets.only(right: size.width * 0.05),
  //                         child: const Icon(Icones_Personalizado.place,
  //                             color: Colors.black, size: 35),
  //                       ),
  //                       labelText: 'Nome Setor',
  //                       labelStyle: const TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
  //                 child: Form(
  //                   child: TextFormField(
  //                     //controller: controller.descricao,
  //                     style: const TextStyle(
  //                         wordSpacing: 1, fontSize: 18, color: Colors.black),
  //                     decoration: const InputDecoration(
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(25),
  //                           topRight: Radius.circular(25),
  //                           bottomLeft: Radius.circular(25),
  //                           bottomRight: Radius.circular(25),
  //                         ),
  //                         borderSide:
  //                             BorderSide(color: Colors.black, width: 0.9),
  //                       ),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(25),
  //                           topRight: Radius.circular(25),
  //                           bottomLeft: Radius.circular(25),
  //                           bottomRight: Radius.circular(25),
  //                         ),
  //                       ),
  //                       labelStyle: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 18,
  //                       ),
  //                       labelText: 'Descrição',
  //                       alignLabelWithHint: true,
  //                     ),
  //                     maxLines: 5,
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 15),
  //               Container(
  //                 padding: const EdgeInsets.all(20.0),
  //                 child: Center(
  //                   child: ElevatedButton(
  //                     onPressed: () async {
  //                       // var result = await controller.goToInsert();
  //                       // if (result == 'true') {
  //                       //   controller.toast('Gravado com sucesso!');
  //                       // } else {
  //                       //   final snackBar = SnackBar(
  //                       //     elevation: 0,
  //                       //     behavior: SnackBarBehavior.floating,
  //                       //     backgroundColor: Colors.transparent,
  //                       //     content: AwesomeSnackbarContent(
  //                       //       title: 'Alerta',
  //                       //       message: result.toString(),
  //                       //       contentType: ContentType.failure,
  //                       //     ),
  //                       //   );
  //                       //   // ignore: use_build_context_synchronously
  //                       //   ScaffoldMessenger.of(context)
  //                       //     ..hideCurrentSnackBar()
  //                       //     ..showSnackBar(snackBar);
  //                       // }
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: const Color.fromARGB(255, 116, 7, 7),
  //                       fixedSize: const Size(250, 50),
  //                     ),
  //                     child: const Text(
  //                       'Registrar',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontFamily: 'Roboto-BoldItalic',
  //                         fontSize: 18,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
