import 'package:cge_app/app/core/app_theme.dart';
import 'package:cge_app/app/modules/Tecnico/vistoria/vistoria_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui' as ui;


DateTime selectedDate = DateTime.now();
String updatedDt = DateFormat("dd/MM/y").format(selectedDate);
String updatedDt2 = DateFormat("y-MM-dd").format(selectedDate);


class VistoriaPage extends GetView<VistoriaController> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: VistoriaState(
            title: '',
          )),
    );
  }
}

class VistoriaState extends StatefulWidget {
  const VistoriaState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Vistoria createState() => Vistoria();
}


class Vistoria extends State<VistoriaState> with SingleTickerProviderStateMixin {
  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;

  bool isSelectmanometro = false;
  bool isSelectparede = false;
  bool isSelectpiso = false;
  bool isSelectacesso = false;
  bool isSelectmangueira = false;
  bool isSelectlacre = false;
  bool isSelectaprovado = false;

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      cancelText: "CANCELAR",
      builder: (context, child) => 
      Theme(
        data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4C131A),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: const ColorScheme.light(primary: Color.fromARGB(255, 190, 0, 0)).copyWith(secondary: const Color(0xFF4C131A))),
          child: child!,
      )
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          title: Row(
            children: [
              const Icon(Icons.arrow_back,
              color: Colors.white),
              const SizedBox(width: 20),
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
              const Text('Vistoria',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          centerTitle: true,
        ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/registro.jpeg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Center(
                  child: Container(
                height: 140,
                width: 140,
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/cge.png'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ]),
              )),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 50, left: 40, right: 40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 0, top: 8),
                        padding: const EdgeInsets.only(bottom: 0),
                      ),
                      Row(
                        children: [
                          const Text('Data da Manutenção',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                color: Colors.white,
                              )),
                          const SizedBox(width: 8),
                          IconButton(
                          icon: const Icon(Icons.calendar_month_rounded, color: Colors.white), 
                          color: Colors.white,
                          iconSize: 35,
                          onPressed: () => _selectDate(context)
                          ),
                          ]
                        ),
                      const SizedBox(height: 27),
                      Row(
                        children: [
                          const Icon(Icons.speed_outlined, color: Colors.white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Manômetro',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 77),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectmanometro = !isSelectmanometro;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectmanometro ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectmanometro ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectmanometro ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.fire_extinguisher_outlined,
                              color: Colors.white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Sinalização Parede',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 13),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectparede = !isSelectparede;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectparede ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectparede ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectparede ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(
                            Ionicons.footsteps_outline,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Sinalização Piso',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 37),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectpiso = !isSelectpiso;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectpiso ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectpiso ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectpiso ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Ionicons.enter_outline, color: Colors.white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Acesso',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 112),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectacesso = !isSelectacesso;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectacesso ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectacesso ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectacesso ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Ionicons.headset_outline, color: Colors.white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Mangueira',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 82),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectmangueira = !isSelectmangueira;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectmangueira ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectmangueira ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectmangueira ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Ionicons.headset_outline, color: Colors.white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Lacre',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 126),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectlacre = !isSelectlacre;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectlacre ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectlacre ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectlacre ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Ionicons.thumbs_up_outline, color: Colors.white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Aprovado',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 88),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectaprovado = !isSelectaprovado;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastLinearToSlowEaseIn,
                              decoration: BoxDecoration(
                                color: isSelectaprovado ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                                border: isSelectaprovado ? null : Border.all(
                                  color: Colors.black54,
                                  width: 2
                                )
                              ),
                              width: 25,
                              height: 25,
                              child: isSelectaprovado ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              ) : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  fixedSize: const Size(200, 50)),
                              child: const Text(
                                'Registrar',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto-BoldItalic',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
