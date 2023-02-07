import 'package:cge_app/app/core/app_theme.dart';
import 'package:cge_app/app/modules/cadastro_setor/page.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';

import 'controller.dart';

class Setor extends GetView<SetorController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: TextDirection.ltr,
          child: SetorState(
            title: '',
          )),
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
  var number = faker.randomGenerator.integer(50);
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
              child: const Text(
                '03/02/2023',
                style: TextStyle(fontSize: 16, color: Colors.white),
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
            onPressed: () {},
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
            Bubble(
              title: "Editar Setor",
              iconColor: Colors.white,
              bubbleColor: const Color.fromARGB(255, 190, 0, 0),
              icon: Icons.edit_rounded,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CadastroSetorPage(),
                  ),
                );
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Cadastrar Setor",
              iconColor: Colors.white,
              bubbleColor: const Color.fromARGB(255, 190, 0, 0),
              icon: Icons.add_rounded,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CadastroSetorPage(),
                  ),
                );
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Realizar Vistoria",
              iconColor: Colors.white,
              bubbleColor: const Color.fromARGB(255, 190, 0, 0),
              icon: Icons.check_circle_outline,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
              },
            ),
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
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/registro.jpeg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              for (var i = 1; i <= 10; i++) ...[
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    surfaceTintColor: const Color.fromARGB(255, 201, 201, 201),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(faker.lorem.words(2).join(' '),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 131, 30, 23),
                                  fontStyle: FontStyle.italic)),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        'Extintores Funcional',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 78, 78, 78),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.circle,
                                          size: 20, color: Colors.yellow),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        'Extintores a Vencer',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 78, 78, 78),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.circle,
                                          size: 20, color: Colors.red),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        'Extintores Vencidos',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 78, 78, 78),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: Container(
                                padding: const EdgeInsets.all(7.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    'https://picsum.photos/250?image=${i + number}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
