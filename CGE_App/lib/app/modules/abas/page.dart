import 'package:cge_app/app/modules/dashboard/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../extintores/page.dart';
import '../setores/page.dart';
import 'controller.dart';

class AbaPage extends GetView<AbaController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 175, 31, 21),
              bottom: const TabBar(
                tabs: [
                  Text('Setores', style: TextStyle(fontSize: 20)),
                  Text('Extintores', style: TextStyle(fontSize: 20))
                ],
                indicatorColor: Colors.white,
              ),
              shadowColor: Colors.white,
              title: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/image/cge.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: const Icon(
                        Icons.warning_rounded,
                        size: 40,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: const Icon(
                        Icons.update_rounded,
                        size: 40,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Setor(),
                Extintor(),
              ],
            ),
          ),
        ));
  }
}
