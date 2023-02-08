import 'package:cge_app/app/data/Models/subject_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'controller.dart';

class CadastroExtintorPage extends GetView<CadastroExtintorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          title: Row(
            children: [
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
              const Text('Cadastro de Extintor',
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
              child: ListView(children: [
                Center(
                    child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 80),
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
                  margin:
                      const EdgeInsets.only(bottom: 100, left: 50, right: 50),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Form(
                            child: TextFormField(
                            style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                              icon: Icon(Icons.fire_extinguisher_outlined,
                              color: Colors.white,
                              size: 27,),
                              labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Nº do Extintor',
                          ),
                        ),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Form(
                            child: TextFormField(
                            style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                              icon: Icon(Icons.fire_extinguisher_outlined,
                              color: Colors.white,
                              size: 27,),
                              labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Nº do Extintor',
                          ),
                        ),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Form(
                            child: TextFormField(
                            style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                              icon: Icon(Icons.fire_extinguisher_outlined,
                              color: Colors.white,
                              size: 27,),
                              labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            labelText: 'Nº do Extintor',
                          ),
                        ),),
                      ),
                      GetBuilder<CadastroExtintorController>(builder: (controller) {
                        return Container(
                         padding: const EdgeInsets.all(10.0),
                          child: MultiSelectDialogField(
                           dialogHeight: 200,
                            items: controller.dropDownData,
                            title: const Text("Tipo do Extintor",
                            style: TextStyle(color: Colors.black)),
                           selectedColor: Colors.black,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: Colors.black,
                                width: 2
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            buttonText: const Text(
                              "Tipo do Extintor",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              var subjectData = [];
                              for(var i = 0; i < results.length; i++) {
                                SubjectModel data = results[i] as SubjectModel;
                                print(data.subjectId);
                                print(data.subjectName);
                                subjectData.add(data.subjectId);
                              }
                              print("data $subjectData");
                            },
                          ));
                      }),
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
                    ],
                  ),
                ),
              ]
              )
              ),              
        ));
  }
}
