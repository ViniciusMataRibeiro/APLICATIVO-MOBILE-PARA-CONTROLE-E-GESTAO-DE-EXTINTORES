import 'package:cge_app/app/modules/vistoria/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class VistoriaPage extends GetView<VistoriaController> {
  const VistoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/registro.jpeg'),
                        fit: BoxFit.cover)),
                child: ListView(
                  children:  [
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
                    margin:
                        const EdgeInsets.only(bottom: 50, left: 40, right: 40),
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
                            Text('Pressão',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 130),
                            Checkbox(value: true, onChanged: null)
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Text('Mangueira',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 113),
                            Checkbox(value: true, onChanged: null)
                          ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                            Text('Lacre',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 150),
                            Checkbox(value: true, onChanged: null)
                          ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                            Text('Piso',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 158),
                            Checkbox(value: true, onChanged: null)
                          ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                            Text('Parede',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 141),
                            Checkbox(value: true, onChanged: null)
                          ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                            Text('Acesso',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 138),
                            Checkbox(value: true, onChanged: null)
                          ],
                          ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Text('Validade da Recarga',
                            style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )),
                            SizedBox(width: 46),
                            Checkbox(value: true, onChanged: null)
                          ],
                        )
                      ]
                  ),
                  ),
                  ],
                ),
                ),
      ),
    );
  }
}