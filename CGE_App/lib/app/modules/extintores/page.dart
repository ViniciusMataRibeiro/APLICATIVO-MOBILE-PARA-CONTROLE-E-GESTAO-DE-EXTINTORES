import 'package:faker/faker.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_theme.dart';
import 'controller.dart';

class Extintor extends GetView<ExtintorController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: TextDirection.ltr,
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
  var letra = <String>[];
  late Animation<double> _animation;
  late AnimationController _animationController;

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
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 10; i++) {
      var char = faker.randomGenerator.fromCharSet('ABCK', 1);
      letra.add(char);
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 70),
          child: FloatingActionBubble(
            herotag: UniqueKey(),
            items: <Bubble>[
              Bubble(
                title: "Settings",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.settings,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
              Bubble(
                title: "Editar Extintor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.edit_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadSetor');
                  _animationController.reverse();
                },
              ),
              Bubble(
                title: "Cadastrar Extintor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 190, 0, 0),
                icon: Icons.add_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Get.toNamed('/cadExtintor');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             CadastroSetorPage()));
                  _animationController.reverse();
                },
              ),
            ],
            animation: _animation,
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),
            iconColor: Colors.white,
            iconData: Icons.home_rounded,
            backGroundColor: const Color.fromARGB(255, 190, 0, 0),
          ),
        ),
        body: Center(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/registro.jpeg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              for (var i = 0; i < 10; i++) ...[
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    surfaceTintColor: const Color.fromARGB(255, 201, 201, 201),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              'Extintor Nº ${faker.randomGenerator.integer(99)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 131, 30, 23),
                                  fontStyle: FontStyle.italic)),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.circle,
                                          size: 20, color: Colors.green),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text('Data de Vencimento',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color:
                                                Color.fromARGB(255, 78, 78, 78),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.circle,
                                          size: 20, color: Colors.green),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text('Última Inspeção',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color:
                                                Color.fromARGB(255, 78, 78, 78),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.circle,
                                          size: 20, color: Colors.green),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text('Informações do Extintor',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color:
                                                Color.fromARGB(255, 78, 78, 78),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/image/Classe-${letra[i]}.jpg',
                                        fit: BoxFit.cover,
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        )));
  }
}
