import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class PrintQrCode extends StatefulWidget {
  const PrintQrCode({super.key, required this.data});
  final List<Map<String, dynamic>> data;

  @override
  State<PrintQrCode> createState() => _PrintQrCodeState();
}

class _PrintQrCodeState extends State<PrintQrCode> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected=await bluetoothPrint.isConnected??false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('BluetoothPrint example app'),
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
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(tips),
                      ),
                    ],
                  ),
                  const Divider(),
                  StreamBuilder<List<BluetoothDevice>>(
                    stream: bluetoothPrint.scanResults,
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: snapshot.data!.map((d) => ListTile(
                        title: Text(d.name??''),
                        subtitle: Text(d.address??''),
                        onTap: () async {
                          setState(() {
                            _device = d;
                          });
                        },
                        trailing: _device!=null && _device!.address == d.address?const Icon(
                          Icons.check,
                          color: Colors.green,
                        ):null,
                      )).toList(),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlinedButton(
                              onPressed:  _connected?null:() async {
                                if(_device!=null && _device!.address !=null){
                                  setState(() {
                                    tips = 'connecting...';
                                  });
                                  await bluetoothPrint.connect(_device!);
                                }else{
                                  setState(() {
                                    tips = 'please select device';
                                  });
                                  print('please select device');
                                }
                              },
                              child: const Text('connect'),
                            ),
                            const SizedBox(width: 10.0),
                            OutlinedButton(
                              onPressed:  _connected?() async {
                                setState(() {
                                  tips = 'disconnecting...';
                                });
                                await bluetoothPrint.disconnect();
                              }:null,
                              child: const Text('disconnect'),
                            ),
                          ],
                        ),
                        const Divider(),
                        OutlinedButton(
                          onPressed:  _connected?() async {
                            Map<String, dynamic> config = Map();
                            config['width'] = 40; // 标签宽度，单位mm
                            config['height'] = 70; // 标签高度，单位mm
                            config['gap'] = 2; // 标签间隔，单位mm

                            // x、y坐标位置，单位dpi，1mm=8dpi
                            List<LineText> list = [];
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: 'A Title'));
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:40, content: 'this is content'));
                            list.add(LineText(type: LineText.TYPE_QRCODE, x:10, y:70, content: 'qrcode i\n'));
                            list.add(LineText(type: LineText.TYPE_BARCODE, x:10, y:190, content: 'qrcode i\n'));

                            await bluetoothPrint.printLabel(config, list);
                          }:null,
                          child: const Text('print label(tsc)'),
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
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }
}
