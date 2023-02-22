import 'package:cge_app/app/Icones/icones_personalizado.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'package:cge_app/app/data/Models/subject_data_model.dart';
import 'package:cge_app/app/modules/Extintor/cadastro_extintor/cadastroExtintor_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:ui' as ui;


DateTime selectedDate = DateTime.now();
String updatedDt = DateFormat("dd/MM/y").format(selectedDate);
String updatedDt2 = DateFormat("y-MM-dd").format(selectedDate);


class CadastroExtintorPage extends GetView<CadastroExtintorController> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: CadastroExtintorState(
            title: '',
          )),
    );
  }
}



class CadastroExtintorState extends StatefulWidget {
  const CadastroExtintorState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  CadastroExtintor createState() => CadastroExtintor();
}


class CadastroExtintor extends State<CadastroExtintorState> with SingleTickerProviderStateMixin {
  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;

  var mask = MaskTextInputFormatter(mask: "##/##/####");

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
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                              icon: Icon(Icones_Personalizado.fire_extinguisher,
                              color: Colors.white,
                              size: 27,),
                              labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            labelText: 'Nº do Extintor',
                          ),
                        ),),
                      ),
                      Container(                      
                        margin: const EdgeInsets.only(left: 0),
                        child: Form(
                            child: TextFormField(
                            inputFormatters: [mask],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: '31/12/2022',
                              hintStyle: TextStyle(
                                color: Colors.white
                              ),
                              icon: Icon(Icones_Personalizado.fire_extinguisher,
                              color: Colors.white,
                              size: 27,),
                              labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            suffixIcon: Icon(Icons.date_range_outlined,
                            color: Colors.white,),
                            labelText: 'Validade Extintor',
                          ),
                        ),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: Form(
                            child: TextFormField(
                              inputFormatters: [mask],
                              keyboardType: TextInputType.number,
                            style: const TextStyle(
                              wordSpacing: 1,
                              fontSize: 18, color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: '31/12/2022',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              icon: Icon(Icones_Personalizado.fire_extinguisher,
                              color: Colors.white,
                              size: 27,),
                              labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            suffixIcon: Icon(Icons.date_range_outlined,
                            color: Colors.white,),
                            labelText: 'Validade do Casco',
                          ),
                        ),),
                      ),
                      GetBuilder<CadastroExtintorController>(builder: (controller) {
                        return Container(
                         width: 350,
                         margin: const EdgeInsets.only(top: 10),
                         padding: const EdgeInsets.all(10.0),
                          child: MultiSelectDialogField(
                           dialogHeight: 200,
                            items: controller.dropDownData,
                            title: const Text("Tipo do Extintor",
                            style: TextStyle(color: Colors.black)),
                           selectedColor: Colors.black,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(80, 0, 0, 0),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: const Color.fromARGB(80, 0, 0, 0),
                                width: 2
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            buttonText: const Text(
                              "Tipo do Extintor",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              var subjectData = [];
                              for(var i = 0; i < results.length; i++) {
                                SubjectModel data = results[i] as SubjectModel;
                                subjectData.add(data.subjectName);
                              }
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
