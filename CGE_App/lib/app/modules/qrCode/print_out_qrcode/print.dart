import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class PrintQrCode extends StatefulWidget {
  const PrintQrCode({super.key, required this.data, required this.tipo, required this.nome, this.tipoExtintor});
  final String data;
  final String tipo;
  final String nome;
  final String? tipoExtintor;

  @override
  State<PrintQrCode> createState() => _PrintQrCodeState();
}

class _PrintQrCodeState extends State<PrintQrCode> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
        title: const Text(
          'Selecione uma impressora',
          style: TextStyle(
            color: Colors.white,
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
                                _connected == false ?
                                tips = 'Conectando...' :
                                tips = 'Desconectando...';
                              });
                              _device != null &&
                                    _device!.address == d.address &&
                                    _connected == false
                                ? await bluetoothPrint.connect(_device!)
                                : await bluetoothPrint.disconnect();
                            },
                            trailing:
                              _device != null && _device!.address == d.address && tips != 'Desconectado com sucesso'
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
                    widget.tipo == 'Setor' ?
                    OutlinedButton(
                      onPressed:  _connected?() async {
                        Map<String, dynamic> config = {};

                        List<LineText> list = [];
                        list.add(LineText(type: LineText.TYPE_TEXT, content: '********************************', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_TEXT, content: 'Nome Setor: ${widget.nome}', align: LineText.ALIGN_LEFT, x: 500, relativeX: 0, linefeed: 1));
                        list.add(LineText(linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_QRCODE, align: LineText.ALIGN_CENTER, x:10, y:70,size: 12 , content: widget.data, linefeed: 1));
                        list.add(LineText(linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_TEXT, content: '********************************', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
                        await bluetoothPrint.printLabel(config, list);
                        Get.back();
                      }:null,
                      child: const Text('Imprimir'),
                    )
                    : 
                    OutlinedButton(
                      onPressed:  _connected?() async {
                        Map<String, dynamic> config = {};

                        List<LineText> list = [];
                        list.add(LineText(type: LineText.TYPE_TEXT, content: '********************************', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_TEXT, content: 'Numero Extintor: ${widget.nome}', align: LineText.ALIGN_LEFT, x: 500, relativeX: 0, linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_TEXT, content: 'Tipo: ${widget.tipoExtintor}', align: LineText.ALIGN_LEFT, x: 500, relativeX: 0, linefeed: 1));
                        list.add(LineText(linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_QRCODE, align: LineText.ALIGN_CENTER, x:10, y:70,size: 12 , content: widget.data, linefeed: 1));
                        list.add(LineText(linefeed: 1));
                        list.add(LineText(type: LineText.TYPE_TEXT, content: '********************************', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
                        await bluetoothPrint.printLabel(config, list);
                        Get.back();
                      }:null,
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
