import 'package:cge_app/app/modules/vistoria/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class VistoriaPage extends GetView<VistoriaController> {
  const VistoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      image: AssetImage('assets/image/cge.jpeg'),
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
                        children: const [
                          Text('Data da Manutenção',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                color: Colors.white,
                              )),
                          SizedBox(width: 20),
                          Icon(
                            Icons.date_range_outlined,
                            size: 28,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Icons.speed_outlined, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Manometro',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 17,
                                color: Colors.white,
                              )),
                          SizedBox(width: 60),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Icons.fire_extinguisher_outlined,
                              color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Sinalização Parede',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          SizedBox(width: 2),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(
                            Ionicons.footsteps_outline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Sinalização Piso',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          SizedBox(width: 27),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Ionicons.enter_outline, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Acesso',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          SizedBox(width: 102),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Ionicons.headset_outline, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Mangueira',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          SizedBox(width: 72),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Ionicons.headset_outline, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Lacre',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          SizedBox(width: 115),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Ionicons.thumbs_up_outline, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Aprovado',
                              style: TextStyle(
                                fontFamily: 'Prompt-ExtraBoldItalic',
                                fontSize: 16,
                                color: Colors.white,
                              )),
                          SizedBox(width: 77),
                          Checkbox(value: true, onChanged: null)
                        ],
                      ),
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
