import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';

import 'controller.dart';

class SetorPage extends GetView<SetorController> {
  var number = faker.randomGenerator.integer(50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/cadSetor');
          },
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child: const Icon(Icons.add_rounded, size: 40, color: Colors.white),
        ),
        body: Center(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/registro.jpeg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              for (var i = 1; i <= 10; i++) ...[
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.circle,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text('Extintores Funcional',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 78, 78, 78),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 20, color: Colors.yellow),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text('Extintores a Vencer',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 78, 78, 78),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 20, color: Colors.red),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text('Extintores Vencidos',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 78, 78, 78),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   Animation<double>? _animation;
//   AnimationController? _animationController;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 260),
//     );

//     final curvedAnimation =
//         CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("Animated FAB Menu Option"),
//         ),
//         body: Container(
//           height: double.infinity,
//           color: Colors.yellowAccent[100],
//         ),
//         floatingActionButton: FloatingActionBubble(
//           items: <Bubble>[
//             Bubble(
//               title: "Settings",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.settings,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 _animationController!.reverse();
//               },
//             ),
//             Bubble(
//               title: "Profile",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.people,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 _animationController!.reverse();
//               },
//             ),
//             Bubble(
//               title: "Home",
//               iconColor: Colors.white,
//               bubbleColor: Colors.blue,
//               icon: Icons.home,
//               titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//               onPress: () {
//                 _animationController!.reverse();
//               },
//             ),
//           ],
//           animation: _animation!,
//           onPress: () => _animationController!.isCompleted
//               ? _animationController!.reverse()
//               : _animationController!.forward(),
//           backGroundColor: Colors.blue,
//           iconColor: Colors.white,
//           iconData: Icons.menu,
//         ));
//   }
// }

