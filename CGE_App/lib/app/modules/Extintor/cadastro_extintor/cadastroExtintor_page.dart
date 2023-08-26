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

import '../../qrCode/print_out_qrcode/print.dart';

var newFormat = DateFormat("dd/MM/yyyy");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();

var dt2 = DateTime.now();
String updatedDt2 = newFormat.format(dt2);
String data2 = DateTime.now().toIso8601String();

List dadosSetor = [];

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

  late Future mapa;

  var number = faker.randomGenerator.integer(50);
  // ignore: unused_field
  late Animation<double> _animation;
  late AnimationController _animationController;

  var mask = MaskTextInputFormatter(mask: "##/##/####");

  Future<void> _data(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.dt,
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
      cancelText: "CANCELAR",
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF4C131A),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 116, 7, 7),
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
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
      cancelText: "CANCELAR",
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF4C131A),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 116, 7, 7),
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

    mapa = controller.getSetores();
    controller.getTamanhoExtintor();
    controller.getTipoExtintor();
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
                    width: size.width * 0.08,
                    height: 40,
                  ),
                  Text(
                    controller.alterando
                        ? 'Editar Extintor'
                        : 'Cadastrar Extintor',
                    style: const TextStyle(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: buildContainerCombo(),
    );
  }

  buildContainerCombo() {
    return FutureBuilder(
      future: mapa,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dadosSetor = temp['dadosSetores'];
          if (dadosSetor.isNotEmpty) {
            return Scaffold(
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
                          margin: const EdgeInsets.only(top: 20, bottom: 30),
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
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 50),
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
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
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
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.date_range_outlined,
                                size: 40,
                                color: Colors.black,
                              ),
                              isThreeLine: false,
                              subtitle: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Validade do Casco',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _data(context);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: controller.alterando
                                      ? newFormat.format(controller.dt)
                                      : updatedDt,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.date_range_outlined,
                                color: Colors.black,
                                size: 40,
                              ),
                              isThreeLine: false,
                              subtitle: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Validade Exintor',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _data2(context);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: controller.alterando
                                      ? newFormat.format(controller.dt2)
                                      : updatedDt2,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Ionicons.resize_outline,
                                color: Colors.black,
                                size: 35,
                              ),
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
                                  labelText: 'Selecione o Tamanho',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: InkWell(
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      'Selecione o Tamanho',
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
                                                    height: 220,
                                                    width: 200,
                                                    child: CustomScrollView(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      slivers: [
                                                        SliverFillRemaining(
                                                          fillOverscroll: true,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: controller
                                                                .dadosExtintorTamanho
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              Map item = controller
                                                                      .dadosExtintorTamanho[
                                                                  index];
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _selectItemTamanhoExtintor(
                                                                        item,
                                                                        controller);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  title: Text(item[
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
                                controller: TextEditingController(
                                  text: controller.selectedTamanho,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Ionicons.flame_outline,
                                color: Colors.black,
                                size: 35,
                              ),
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
                                  labelText: 'Selecione o Tipo',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: InkWell(
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Text(
                                                      'Selecione o Tipo',
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
                                                          fillOverscroll: true,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: controller
                                                                .dadosExtintorTipo
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              Map item = controller
                                                                      .dadosExtintorTipo[
                                                                  index];
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _selectItemTipoExtintor(
                                                                        item,
                                                                        controller);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  title: Text(item[
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
                                controller: TextEditingController(
                                  text: controller.selectedTipo,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icones_Personalizado.place,
                                color: Colors.black,
                                size: 35,
                              ),
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
                                  labelText: 'Selecione o Setor',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  suffixIcon: InkWell(
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
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
                                                          fillOverscroll: true,
                                                          child:
                                                              ListView.builder(
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
                                                                  setState(() {
                                                                    _selectItem(
                                                                        item,
                                                                        controller);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: ListTile(
                                                                  title: Text(item[
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
                                controller: TextEditingController(
                                  text: controller.nomeSetor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var result = await controller.goToInsert();
                                    if (result != 'Algo deu Errado') {
                                      // ignore: use_build_context_synchronously
                                      await _showMyDialog(result);
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

  Future<void> _showMyDialog(String result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja imprimir o QRCode referente ao Setor?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Imprimir'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrintQrCode(
                      data: result,
                      tipo: 'Extintor',
                      nome: controller.nome.text,
                      tipoExtintor: controller.selectedTipo,
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}

// ignore: camel_case_types
class _selectItem {
  _selectItem(Map item, CadastroExtintorController controller) {
    controller.nomeSetor = item['nome'];
    controller.idSetor = item['id'];
  }
}

// ignore: camel_case_types
class _selectItemTamanhoExtintor {
  _selectItemTamanhoExtintor(Map item, CadastroExtintorController controller) {
    controller.selectedTamanho = item['nome'];
  }
}

// ignore: camel_case_types
class _selectItemTipoExtintor {
  _selectItemTipoExtintor(Map item, CadastroExtintorController controller) {
    controller.selectedTipo = item['nome'];
  }
}
