import 'package:cge_app/app/modules/vistoria/vistoria/vistoria_controller.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../Icones/icones_personalizado.dart';
import 'package:cge_app/app/core/app_theme.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

var newFormat = DateFormat("dd/MM/y");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();
List dadosSetor = [];

class VistoriaPage extends GetView<VistoriaController> {
  const VistoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: VistoriaState(
          title: '',
        ),
      ),
    );
  }
}

class VistoriaState extends StatefulWidget {
  const VistoriaState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Vistoria createState() => Vistoria();
}

class Vistoria extends State<VistoriaState>
    with SingleTickerProviderStateMixin {
  VistoriaController controller = Get.put(VistoriaController());
  var number = faker.randomGenerator.integer(50);
  // ignore: unused_field
  late Animation<double> _animation;
  late AnimationController _animationController;

  late Future mapa;

  // ignore: unused_element
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
      setState(
        () {
          dt = picked;
          data = dt.toIso8601String();
          updatedDt = newFormat.format(picked);
        },
      );
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

    mapa = controller.getSetores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: size.width * 0.2,
                    height: 40,
                  ),
                  const Text(
                    'Vistoria',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(25),
        //     bottomRight: Radius.circular(25),
        //   ),
        // ),
      ),
      body: buildContainerCombo(),
    );
  }

  buildContainerCombo() {
    return FutureBuilder(
      future: mapa,
      builder: (context, snapshot) {
        var size = MediaQuery.of(context).size;
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dadosSetor = temp['dadosSetores'];
          if (dadosSetor.isNotEmpty) {
            return Scaffold(
              body: Center(
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
                              image: AssetImage('assets/image/login.png'),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 0),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 50, left: 30, right: 30),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.date_range_outlined,
                                size: 35,
                                color: Colors.black,
                              ),
                              title: const Text(
                                "Data da Vistoria",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isThreeLine: false,
                              subtitle: Text(
                                updatedDt,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              selected: true,
                              selectedTileColor: Colors.black,
                              title: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Selecione o Setor',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        right: size.width * 0.04),
                                    child: const Icon(
                                      Icones_Personalizado.place,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/image/LogOut.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        'Selecione o Setor',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      color: Colors.black,
                                                      thickness: 2,
                                                    ),
                                                    SizedBox(
                                                      height: 330,
                                                      width: 200,
                                                      child: CustomScrollView(
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        slivers: [
                                                          SliverFillRemaining(
                                                            fillOverscroll:
                                                                true,
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  dadosSetor
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                Map item =
                                                                    dadosSetor[
                                                                        index];
                                                                return InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _selectItem(
                                                                          item,
                                                                          'setor',
                                                                          controller);
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                        item[
                                                                            'nome']),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                ),
                                controller: TextEditingController(
                                  text: controller.nomeSetor,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              selected: true,
                              selectedTileColor: Colors.black,
                              subtitle: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Selecione o Extintor',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        right: size.width * 0.04),
                                    child: const Icon(
                                      Icones_Personalizado.fire_extinguisher,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/image/LogOut.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Text(
                                                        'Selecione o Extintor',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      color: Colors.black,
                                                      thickness: 2,
                                                    ),
                                                    SizedBox(
                                                      height: 330,
                                                      width: 200,
                                                      child: CustomScrollView(
                                                        physics:
                                                            const AlwaysScrollableScrollPhysics(),
                                                        slivers: [
                                                          SliverFillRemaining(
                                                            fillOverscroll:
                                                                true,
                                                            child: ListView
                                                                .builder(
                                                              itemCount: controller
                                                                  .dadosExtintor
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                Map item =
                                                                    controller
                                                                            .dadosExtintor[
                                                                        index];
                                                                return InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _selectItem(
                                                                          item,
                                                                          'extintor',
                                                                          controller);
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    title: Text(
                                                                        item[
                                                                            'nome']),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                ),
                                controller: TextEditingController(
                                  text: controller.nomeExtintor,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.speed_outlined,
                                  color: Colors.black, size: 35),
                              title: const Text(
                                'Manômetro',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      controller.isSelectmanometro =
                                          !controller.isSelectmanometro;
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  decoration: BoxDecoration(
                                    color: controller.isSelectmanometro
                                        ? const Color.fromARGB(255, 116, 7, 7)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: controller.isSelectmanometro
                                        ? null
                                        : Border.all(
                                            color: Colors.black, width: 2),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: controller.isSelectmanometro
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                  Icons.fire_extinguisher_outlined,
                                  color: Colors.black,
                                  size: 35),
                              title: const Text(
                                'Sinalização Parede',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      controller.isSelectparede =
                                          !controller.isSelectparede;
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  decoration: BoxDecoration(
                                    color: controller.isSelectparede
                                        ? const Color.fromARGB(255, 116, 7, 7)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: controller.isSelectparede
                                        ? null
                                        : Border.all(
                                            color: Colors.black, width: 2),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: controller.isSelectparede
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Ionicons.footsteps_outline,
                                  color: Colors.black, size: 35),
                              title: const Text(
                                'Sinalização Piso',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      controller.isSelectpiso =
                                          !controller.isSelectpiso;
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  decoration: BoxDecoration(
                                    color: controller.isSelectpiso
                                        ? const Color.fromARGB(255, 116, 7, 7)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: controller.isSelectpiso
                                        ? null
                                        : Border.all(
                                            color: Colors.black, width: 2),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: controller.isSelectpiso
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Ionicons.enter_outline,
                                  color: Colors.black, size: 35),
                              title: const Text(
                                'Acesso',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      controller.isSelectacesso =
                                          !controller.isSelectacesso;
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  decoration: BoxDecoration(
                                    color: controller.isSelectacesso
                                        ? const Color.fromARGB(255, 116, 7, 7)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: controller.isSelectacesso
                                        ? null
                                        : Border.all(
                                            color: Colors.black, width: 2),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: controller.isSelectacesso
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                width: size.width * 0.1,
                                height: 45,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/icon_mangueira.png'),
                                    fit: BoxFit
                                        .contain, // Ajuste da imagem dentro do contêiner
                                  ),
                                ),
                              ),
                              title: const Text(
                                'Mangueira',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      controller.isSelectmangueira =
                                          !controller.isSelectmangueira;
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  decoration: BoxDecoration(
                                    color: controller.isSelectmangueira
                                        ? const Color.fromARGB(255, 116, 7, 7)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: controller.isSelectmangueira
                                        ? null
                                        : Border.all(
                                            color: Colors.black, width: 2),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: controller.isSelectmangueira
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image/icon_lacre.png'),
                                    fit: BoxFit
                                        .contain, // Ajuste da imagem dentro do contêiner
                                  ),
                                ),
                              ),
                              title: const Text(
                                'Lacre',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      controller.isSelectlacre =
                                          !controller.isSelectlacre;
                                    },
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  decoration: BoxDecoration(
                                    color: controller.isSelectlacre
                                        ? const Color.fromARGB(255, 116, 7, 7)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: controller.isSelectlacre
                                        ? null
                                        : Border.all(
                                            color: Colors.black, width: 2),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: controller.isSelectlacre
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black, thickness: 1),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Form(
                                child: TextFormField(
                                  controller: controller.descricao,
                                  style: const TextStyle(
                                      wordSpacing: 1,
                                      fontSize: 18,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    labelText: 'Observações',
                                    alignLabelWithHint: true,
                                  ),
                                  maxLines: 4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var result = await controller.goToInsert();
                                    if (result == 'true') {
                                      controller
                                          .toast('Registrado com sucesso');
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
                                        const Color.fromARGB(255, 116, 7, 7),
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
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Nenhum dado encontrado'),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// ignore: camel_case_types
class _selectItem {
  _selectItem(Map item, String tipoCampo, VistoriaController controller) {
    switch (tipoCampo) {
      case 'setor':
        controller.nomeSetor = item['nome'];
        controller.idSetor = item['id'];
        controller.nomeExtintor = "";
        controller.getExtintores(controller.idSetor);
        break;
      case 'extintor':
        controller.nomeExtintor = item['nome'];
        controller.idExtintor = item['id'];
        break;
    }
  }
}
