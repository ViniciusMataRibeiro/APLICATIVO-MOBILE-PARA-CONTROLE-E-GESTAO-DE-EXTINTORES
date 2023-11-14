import 'package:floating_action_bubble/floating_action_bubble.dart';
import '../../../Icones/icones_personalizado.dart';
import '../../../data/services/auth/service.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'setor_details_controller.dart';
import '../../../core/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

List dados = [];

class SetorDetails extends GetView<SetorDetailsController> {
  const SetorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: SetorDetailsState(
            title: '',
          )),
    );
  }
}

class SetorDetailsState extends StatefulWidget {
  const SetorDetailsState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  SetorDetailsPage createState() => SetorDetailsPage();
}

class SetorDetailsPage extends State<SetorDetailsState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  SetorDetailsController controller = Get.put(
    SetorDetailsController(),
  );

  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future mapa;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    mapa = controller.getExtintor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var obj = aux.user.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                    width: size.width * 0.05,
                    height: 40,
                  ),
                  const Text(
                    'Detalhes do Extintor',
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: FloatingActionBubble(
          herotag: UniqueKey(),
          items: <Bubble>[
            if (obj!.tipo == 'empresa')
              ...[]
            else ...[
              Bubble(
                title: "Cadastra Extintor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.check_rounded,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () async {
                  await controller.gotoCreateExtintor(dados[0]);
                  setState(() {
                    mapa = controller.getExtintor();
                  });
                },
              ),
              Bubble(
                title: "Editar Setor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.edit,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () async {
                  await controller.gotoEditSetor(dados[0]);
                  setState(() {
                    mapa = controller.getExtintor();
                  });
                },
              ),
              Bubble(
                title: "Excluir Setor",
                iconColor: Colors.white,
                bubbleColor: const Color.fromARGB(255, 116, 7, 7),
                icon: Icons.delete,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  controller.gotoDeleteSetor(dados[0]);
                },
              ),
            ],
          ],
          animation: _animation,
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
          iconColor: Colors.white,
          iconData: Icons.handyman_outlined,
          backGroundColor: const Color.fromARGB(255, 116, 7, 7),
        ),
      ),
      body: buildContainer(),
    );
  }

  buildContainer() {
    return FutureBuilder(
      future: mapa,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dados = temp['dados'];
          if (dados.isNotEmpty) {
            return Scaffold(
              body: Center(
                child: _mostradados(dados: dados),
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

  _mostradados({required List dados}) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: dados.length,
      padding: const EdgeInsets.only(bottom: 30, top: 50),
      itemBuilder: (BuildContext context, index) {
        Map item = dados[index];
        return GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Extintor",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          height: 2,
                          color: Colors.grey,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 7.0),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(left: 0, right: 15),
                                  title: const Text(
                                    'Ativo',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      decoration: BoxDecoration(
                                        color: item['ativo']
                                            ? Colors.green
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: item['ativo']
                                            ? null
                                            : Border.all(
                                                color: Colors.black, width: 1),
                                      ),
                                      width: 20,
                                      height: 20,
                                      child: item['manimetro']
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: item['nome'],
                                  decoration: const InputDecoration(
                                    labelText: 'Número Extintor',
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child: Icon(Icones_Personalizado
                                          .fire_extinguisher),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(item['validadeCasco'])),
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child:
                                          Icon(Icons.calendar_today_outlined),
                                    ),
                                    labelText: 'Validade do Casco',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(item['validadeExtintor'])),
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child:
                                          Icon(Icons.calendar_today_outlined),
                                    ),
                                    labelText: 'Validade do Extintor',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 35, right: 35, bottom: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: DateFormat('dd/MM/yyyy').format(
                                      DateTime.parse(
                                          item['proximaManutencao'])),
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child:
                                          Icon(Icons.calendar_today_outlined),
                                    ),
                                    labelText: 'Proxima Vistoria',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 35, right: 35, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: item['tipoExtintor'],
                                  decoration: const InputDecoration(
                                    labelText: 'Tipo do Extintor',
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child: Icon(Ionicons.flame_outline),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 35, right: 35, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: '${item['tamanho'] ?? 0} Kg',
                                  decoration: const InputDecoration(
                                    labelText: 'Tamanho do Extintor',
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child: Icon(Ionicons.resize_outline),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 35, right: 35, bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: item['setor'],
                                  decoration: const InputDecoration(
                                    labelText: 'Setor',
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              15), // add padding to adjust icon
                                      child: Icon(Icones_Personalizado.place),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
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
              ),
              item['ultimaVistoria'] == null
                  ? Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    left: 5.0,
                                    right: 5.0,
                                    bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Última Vistoria",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Container(
                                height: 2,
                                color: Colors.grey,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 7.0),
                              ),
                              SizedBox(height: size.height * 0.01),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Nenhuma Vistoria Realizada',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    left: 5.0,
                                    right: 5.0,
                                    bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Última Vistoria",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Container(
                                height: 2,
                                color: Colors.grey,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 7.0),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(
                                                item['ultimaVistoria'])),
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          labelText: 'Realizada em',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: const Icon(
                                            Icons.speed_outlined,
                                            color: Colors.black,
                                            size: 30),
                                        title: const Text(
                                          'Manômetro',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            decoration: BoxDecoration(
                                              color: item['manimetro']
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: item['manimetro']
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                            ),
                                            width: 20,
                                            height: 20,
                                            child: item['manimetro']
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: const Icon(
                                            Icons.fire_extinguisher_outlined,
                                            color: Colors.black,
                                            size: 30),
                                        title: const Text(
                                          'Sinalização na Parede',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            decoration: BoxDecoration(
                                              color: item['sinalizacaoParede']
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: item['sinalizacaoParede']
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                            ),
                                            width: 20,
                                            height: 20,
                                            child: item['sinalizacaoParede']
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: const Icon(
                                            Ionicons.footsteps_outline,
                                            color: Colors.black,
                                            size: 30),
                                        title: const Text(
                                          'Sinalização do Piso',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            decoration: BoxDecoration(
                                              color: item['sinalizacaoPiso']
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: item['sinalizacaoPiso']
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                            ),
                                            width: 20,
                                            height: 20,
                                            child: item['sinalizacaoPiso']
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: const Icon(
                                            Ionicons.enter_outline,
                                            color: Colors.black,
                                            size: 30),
                                        title: const Text(
                                          'Acesso',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            decoration: BoxDecoration(
                                              color: item['acesso']
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: item['acesso']
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                            ),
                                            width: 20,
                                            height: 20,
                                            child: item['acesso']
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: Container(
                                          width: size.width * 0.09,
                                          height: 30,
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
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            decoration: BoxDecoration(
                                              color: item['mangueira']
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: item['mangueira']
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                            ),
                                            width: 20,
                                            height: 20,
                                            child: item['mangueira']
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, left: 35, right: 35, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: Container(
                                          width: size.width * 0.09,
                                          height: 30,
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
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            decoration: BoxDecoration(
                                              color: item['lacre']
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: item['lacre']
                                                  ? null
                                                  : Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                            ),
                                            width: 20,
                                            height: 20,
                                            child: item['lacre']
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : null,
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
                    ),
            ],
          ),
        );
      },
    );
  }
}
