// ignore_for_file: file_names

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

var newFormat = DateFormat("dd/MM/yyyy");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();

var dt2 = DateTime.now();
String updatedDt2 = newFormat.format(dt2);
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
  CadastroExtintorController controller = Get.put(CadastroExtintorController());

  var number = faker.randomGenerator.integer(50);
  // ignore: unused_field
  late Animation<double> _animation;
  late AnimationController _animationController;

  var mask = MaskTextInputFormatter(mask: "##/##/####");

  Future<void> _data(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.dt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
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
        controller.dt = picked;
        data = controller.dt.toIso8601String();
        updatedDt = newFormat.format(picked);
        controller.validadeCasco.text = updatedDt;
      });
    }
  }

  Future<void> _data2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.dt2,
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
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
        controller.dt2 = picked;
        data2 = controller.dt2.toIso8601String();
        updatedDt2 = newFormat.format(picked);
        controller.validadeExtintor.text = updatedDt2;
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String dateInput() {
    return "";
  }

  GlobalKey<DropdownSearchState<String>> dropdownKey =
      GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
              width: size.width * 0.05,
              height: 40,
            ),
            Text(
              controller.alterando ? 'Alterar Extintor' : 'Cadastrar Extintor',
              style: const TextStyle(
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
                image: AssetImage('assets/image/LogOut.png'),
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
                margin: const EdgeInsets.only(bottom: 50),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icones_Personalizado.fire_extinguisher,
                        color: Colors.black,
                        size: 40,
                      ),
                      title: TextFormField(
                        controller: controller.nome,
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'N° do Extintor',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.date_range_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Validade do Casco",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      subtitle: Text(
                        controller.alterando
                            ? newFormat.format(controller.dt)
                            : updatedDt,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontStyle: FontStyle.italic),
                      ),
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      onTap: () {
                        setState(() {
                          _data(context);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.date_range_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: const Text(
                        "Validade do Casco",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isThreeLine: false,
                      subtitle: Text(
                        controller.alterando
                            ? newFormat.format(controller.dt2)
                            : updatedDt2,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontStyle: FontStyle.italic),
                      ),
                      trailing: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      onTap: () {
                        setState(() {
                          _data2(context);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Tamanho Extintor',
                        hintText: controller.selectedTamanho,
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        prefixIcon: const Icon(
                          Ionicons.resize_outline,
                          color: Colors.black,
                          size: 40,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          'Tamanho Extintor',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 2,
                                      ),
                                      InkWell(
                                        child: ListTile(
                                          title: const Text('4 Kg'),
                                          selected:
                                              controller.selectedTamanho ==
                                                  '4 Kg',
                                        ),
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTamanho = '4 Kg';
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTamanho = '6 Kg';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('6 Kg'),
                                          selected:
                                              controller.selectedTamanho ==
                                                  '6 Kg',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTamanho = '8 Kg';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('8 Kg'),
                                          selected:
                                              controller.selectedTamanho ==
                                                  '8 Kg',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTamanho =
                                                '10 Kg';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('10 Kg'),
                                          selected:
                                              controller.selectedTamanho ==
                                                  '10 Kg',
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                      controller: TextEditingController(
                          text: controller.selectedTamanho),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Tipo Extintor',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        prefixIcon: const Icon(
                          Ionicons.flame_outline,
                          color: Colors.black,
                          size: 40,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          'Tipo Extintor',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 2,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTipo = 'Tipo A';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('Tipo A'),
                                          selected: controller.selectedTipo ==
                                              'Tipo A',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTipo = 'Tipo BC';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('Tipo BC'),
                                          selected: controller.selectedTipo ==
                                              'Tipo BC',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTipo =
                                                'Tipo ABC';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('Tipo ABC'),
                                          selected: controller.selectedTipo ==
                                              'Tipo ABC',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTipo = 'Tipo K';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('Tipo K'),
                                          selected: controller.selectedTipo ==
                                              'Tipo K',
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            controller.selectedTipo =
                                                'Tipo CO²';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: ListTile(
                                          title: const Text('Tipo CO²'),
                                          selected: controller.selectedTipo ==
                                              'Tipo CO²',
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                      controller:
                          TextEditingController(text: controller.selectedTipo),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            var result = await controller.goToInsert();
                            if (result == 'true') {
                              controller.toast('Registrado com sucesso');
                            } else {
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Alerta',
                                  message: result.toString(),
                                  contentType: ContentType.failure,
                                ),
                              );
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }
                          },
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
