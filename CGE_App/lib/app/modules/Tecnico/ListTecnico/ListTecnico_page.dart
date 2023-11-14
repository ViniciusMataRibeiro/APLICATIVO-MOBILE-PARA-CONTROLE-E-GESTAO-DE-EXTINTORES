// ignore_for_file: file_names
import '../../../data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'ListTecnico_controller.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

List dados = [];
bool ativo = true;

class ListTecnico extends GetView<ListTecnicoController> {
  const ListTecnico({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
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
  // ignore: unused_field
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


  late Future mapa;

    _refresh(bool parametro) async {
    try {
      setState(() {
        mapa = controller.getTecnico();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  buildContainer() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: dadosTecnico,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dados = temp['dados'];
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
                          width: size.width * 0.08,
                          height: 40,
                        ),
                        const Text(
                          'Lista de Tecnicos',
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
            ),
            body: 
            
            _mostraDados(dados: dados, controllerTecnico: controller),
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

  _mostraDados(
      {required List dados, required ListTecnicoController controllerTecnico}) {
    return ListView.builder(
      itemCount: dados.length,
      itemBuilder: (context, index) {
        var size = MediaQuery.of(context).size;
        Map item = dados[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7, left: 7, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _nome(item),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 17, right: 17),
                    child: const Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, left: size.width * 0.05, bottom: 10),
                    child: Column(
                      children: [
                        SizedBox(height: size.width * 0.01),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  item['email'],
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.width * 0.03),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.check_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Satus',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                  ),
                                ),
                                item['status'] == 'Inativo'
                                    ? const Text(
                                        'Inativo',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const Text(
                                        'Ativo',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  item['status'] == 'Inativo'
                      ? Container(
                          height: 3,
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                        )
                      : Container(
                          height: 3,
                          color: Colors.green,
                          margin: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                        ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 116, 7, 7),
                          ),
                          onPressed: () {
                            Get.toNamed(
                              '/cadTecnico',
                              arguments: item,
                            );
                          },
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
                          onPressed: () {
                            setState(() {
                              controller.gotoDeleteTecnico(item['id']);
                              if(item['status'] == 'Inativo'){
                                controller.toast('Tecnico Habilitado!');
                              }
                              else{
                                controller.toast('Tecnico Desabilitado!');
                              }
                            });
                            //Get.offAllNamed('/perfil');
                            _refresh(true);
                          },
                          child: item['status'] == 'Inativo'
                              ? const Text(
                                  'Ativar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic),
                                )
                              : const Text(
                                  'Inativar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic),
                                ),
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

Widget _nome(Map item) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item['nome'] ?? 'Sem informação',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );
}
