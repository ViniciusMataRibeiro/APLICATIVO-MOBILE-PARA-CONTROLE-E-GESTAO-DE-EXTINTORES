import 'package:cge_app/app/modules/qrCode/print_out_qrcode/print_out_qrcode_controller.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'dart:async';

class PrintQrCodePage extends GetView<PrintQrCodeController> {
  const PrintQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: PrintQrCodeState(
            title: '',
          )),
    );
  }
}

class PrintQrCodeState extends StatefulWidget {
  const PrintQrCodeState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PrintQrCodeState> createState() => _PrintQrCodeState();
}

class _PrintQrCodeState extends State<PrintQrCodeState>
    with SingleTickerProviderStateMixin {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  PrintQrCodeController controller = Get.put(PrintQrCodeController());

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'Botão imprimir habilitado = conexão ativa';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 2));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      if (kDebugMode) {
        print('******************* cur device status: $state');
      }

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Conexão estabelecida';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Desconectado com sucesso';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
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
                      Get.offAllNamed('/dashboard');
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 0),
                    width: size.width * 0.03,
                    height: 40,
                  ),
                  const Text(
                    'Selecione uma impressora',
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
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              const Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name ?? ''),
                            subtitle: Text(d.address ?? ''),
                            onTap: () async {
                              setState(() {
                                _device = d;
                                _connected == false
                                    ? tips = 'Conectando...'
                                    : tips = 'Desconectando...';
                              });
                              _device != null &&
                                      _device!.address == d.address &&
                                      _connected == false
                                  ? await bluetoothPrint.connect(_device!)
                                  : await bluetoothPrint.disconnect();
                            },
                            trailing: _device != null &&
                                    _device!.address == d.address &&
                                    tips != 'Desconectado com sucesso'
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : null,
                          ))
                      .toList(),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    controller.tipo == 'Setor'
                        ? OutlinedButton(
                            onPressed: _connected
                                ? () async {
                                    Map<String, dynamic> config = {};

                                    List<LineText> list = [];
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            '********************************',
                                        weight: 1,
                                        align: LineText.ALIGN_CENTER,
                                        linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            'Nome Setor: ${controller.nome}',
                                        align: LineText.ALIGN_LEFT,
                                        x: 500,
                                        relativeX: 0,
                                        linefeed: 1));
                                    list.add(LineText(linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_QRCODE,
                                        align: LineText.ALIGN_CENTER,
                                        x: 10,
                                        y: 70,
                                        size: 12,
                                        content: controller.data,
                                        linefeed: 1));
                                    list.add(LineText(linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            '********************************',
                                        weight: 1,
                                        align: LineText.ALIGN_CENTER,
                                        linefeed: 1));
                                    await bluetoothPrint.printLabel(
                                        config, list);
                                    //Get.back();
                                  }
                                : null,
                            child: const Text('Imprimir'),
                          )
                        : OutlinedButton(
                            onPressed: _connected
                                ? () async {
                                    Map<String, dynamic> config = {};

                                    List<LineText> list = [];
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            '********************************',
                                        weight: 1,
                                        align: LineText.ALIGN_CENTER,
                                        linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            'Numero Extintor: ${controller.nome}',
                                        align: LineText.ALIGN_LEFT,
                                        x: 500,
                                        relativeX: 0,
                                        linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            'Tipo: ${controller.tipoExtintor}',
                                        align: LineText.ALIGN_LEFT,
                                        x: 500,
                                        relativeX: 0,
                                        linefeed: 1));
                                    list.add(LineText(linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_QRCODE,
                                        align: LineText.ALIGN_CENTER,
                                        x: 10,
                                        y: 70,
                                        size: 12,
                                        content: controller.data,
                                        linefeed: 1));
                                    list.add(LineText(linefeed: 1));
                                    list.add(LineText(
                                        type: LineText.TYPE_TEXT,
                                        content:
                                            '********************************',
                                        weight: 1,
                                        align: LineText.ALIGN_CENTER,
                                        linefeed: 1));
                                    await bluetoothPrint.printLabel(
                                        config, list);
                                    //Get.back();
                                  }
                                : null,
                            child: const Text('Imprimir'),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () => bluetoothPrint.startScan(
                    timeout: const Duration(seconds: 2)));
          }
        },
      ),
    );
  }
}
