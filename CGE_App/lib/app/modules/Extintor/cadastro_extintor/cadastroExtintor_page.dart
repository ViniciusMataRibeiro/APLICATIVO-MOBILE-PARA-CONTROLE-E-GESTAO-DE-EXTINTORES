// ignore_for_file: file_names

import 'package:cge_app/app/Icones/icones_personalizado.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'package:cge_app/app/modules/Extintor/cadastro_extintor/cadastroExtintor_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:ui' as ui;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ionicons/ionicons.dart';

var newFormat = DateFormat("dd/MM/y");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();

var dt2 = DateTime.now();
String updatedDt2 = newFormat.format(dt);
String data2 = DateTime.now().toIso8601String();

class CadastroExtintorPage extends GetView<CadastroExtintorController> {
  const CadastroExtintorPage({super.key});

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
  const CadastroExtintorState({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  CadastroExtintor createState() => CadastroExtintor();
}

class CadastroExtintor extends State<CadastroExtintorState>
    with SingleTickerProviderStateMixin {
  CadastroExtintorController cadastroExtintorController =
      Get.put(CadastroExtintorController());

  var number = faker.randomGenerator.integer(50);
  // ignore: unused_field
  late Animation<double> _animation;
  late AnimationController _animationController;

  String selectedTamanho = '';
  String selectedTipo = '';

  var mask = MaskTextInputFormatter(mask: "##/##/####");

  Future<void> _data(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      cancelText: "CANCELAR",
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF4C131A),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 190, 0, 0),
          ).copyWith(
            secondary: const Color(0xFF4C131A),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        dt = picked;
        data = dt.toIso8601String();
        updatedDt = newFormat.format(picked);
      });
    }
  }

  Future<void> _data2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dt2,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      cancelText: "CANCELAR",
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF4C131A),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 190, 0, 0),
          ).copyWith(
            secondary: const Color(0xFF4C131A),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        dt2 = picked;
        data2 = dt.toIso8601String();
        updatedDt2 = newFormat.format(picked);
      });
    }
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

  GlobalKey<DropdownSearchState<String>> dropdownKey =
      GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 31, 21),
        title: Row(
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
            const SizedBox(
              width: 5,
            ),
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
            const Text(
              'Cadastro Extintor',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/registro.jpeg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Center(
                child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/cge.png'),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.date_range_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Validade do Casco",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      subtitle: Text(
                        updatedDt,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onTap: () => _data(context),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(
                        Icons.date_range_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Validade Extintor",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      subtitle: Text(
                        updatedDt2,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onTap: () => _data2(context),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'N° do Extintor',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icones_Personalizado.fire_extinguisher,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tamanho Extintor',
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          prefixIcon: const Icon(
                            Ionicons.resize_outline,
                            color: Colors.white,
                            size: 40,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Tamanho Extintor'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTamanho = '4 Kg';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('4 Kg'),
                                            selected: selectedTamanho == '4 Kg',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTamanho = '6 Kg';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('6 Kg'),
                                            selected: selectedTamanho == '6 Kg',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTamanho = '8 Kg';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('8 Kg'),
                                            selected: selectedTamanho == '8 Kg',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTamanho = '10 Kg';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('10 Kg'),
                                            selected:
                                                selectedTamanho == '10 Kg',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        controller:
                            TextEditingController(text: selectedTamanho),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tipo Extintor',
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          prefixIcon: const Icon(
                            Ionicons.flame_outline,
                            color: Colors.white,
                            size: 40,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Tipo do Extintor'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTipo = 'Tipo A';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('Tipo A'),
                                            selected: selectedTipo == 'Tipo A',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTipo = 'Tipo BC';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('Tipo BC'),
                                            selected: selectedTipo == 'Tipo BC',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTipo = 'Tipo ABC';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('Tipo ABC'),
                                            selected:
                                                selectedTipo == 'Tipo ABC',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTipo = 'Tipo K';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('Tipo K'),
                                            selected: selectedTipo == 'Tipo K',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTipo = 'Tipo CO²';
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            title: const Text('Tipo CO²'),
                                            selected:
                                                selectedTipo == 'Tipo CO²',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        controller: TextEditingController(text: selectedTipo),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 175, 31, 21),
                            fixedSize: const Size(250, 50),
                          ),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto-BoldItalic',
                              fontSize: 18,
                            ),
                          ),
                        ),
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
  }
}
