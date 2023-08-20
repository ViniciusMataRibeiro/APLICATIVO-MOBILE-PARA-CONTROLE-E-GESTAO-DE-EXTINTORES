import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PrintQrCode extends StatefulWidget {
  const PrintQrCode({super.key, required this.data});
  final List<Map<String, dynamic>> data;

  @override
  State<PrintQrCode> createState() => _PrintQrCodeState();
}

class _PrintQrCodeState extends State<PrintQrCode> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _deviceMsg = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) {
        setState(() {
          _deviceMsg = 'No devices';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Printer'),
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
      ),
      body: _devices.isEmpty
          ? Center(
              child: Text(_deviceMsg),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: const Icon(Icons.print),
                  title: Text(_devices[i].name!),
                  subtitle: Text(_devices[i].address!),
                  onTap: () {},
                );
              },
            ),
    );
  }

  Future<void> _startPrint(BluetoothDevice? device) async {
    if (device != null && device.address != null) {
      await bluetoothPrint.connect(device);

      Map<String, dynamic> config = {};

      List<LineText> list = [];

      list.add(LineText(type: LineText.TYPE_TEXT, content: '**********************************************', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
      list.add(LineText(type: LineText.TYPE_TEXT, content: '打印单据头', weight: 1, align: LineText.ALIGN_CENTER, fontZoom: 2, linefeed: 1));
      list.add(LineText(linefeed: 1));

      list.add(LineText(type: LineText.TYPE_TEXT, content: '----------------------明细---------------------', weight: 1, align: LineText.ALIGN_CENTER, linefeed: 1));
      list.add(LineText(type: LineText.TYPE_TEXT, content: '物资名称规格型号', weight: 1, align: LineText.ALIGN_LEFT, x: 0,relativeX: 0, linefeed: 0));
      list.add(LineText(type: LineText.TYPE_TEXT, content: '单位', weight: 1, align: LineText.ALIGN_LEFT, x: 350, relativeX: 0, linefeed: 0));
      list.add(LineText(type: LineText.TYPE_TEXT, content: '数量', weight: 1, align: LineText.ALIGN_LEFT, x: 500, relativeX: 0, linefeed: 1));

      list.add(LineText(type: LineText.TYPE_TEXT, content: '混凝土C30', align: LineText.ALIGN_LEFT, x: 0,relativeX: 0, linefeed: 0));
      list.add(LineText(type: LineText.TYPE_TEXT, content: '吨', align: LineText.ALIGN_LEFT, x: 350, relativeX: 0, linefeed: 0));
      list.add(LineText(type: LineText.TYPE_TEXT, content: '12.0', align: LineText.ALIGN_LEFT, x: 500, relativeX: 0, linefeed: 1));

      list.add(LineText(type: LineText.TYPE_TEXT, content: '**********************************************', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
      list.add(LineText(linefeed: 1));

      //ByteData data = await rootBundle.load("assets/images/bluetooth_print.png");
      //List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      //String base64Image = base64Encode(imageBytes);
      // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

      await bluetoothPrint.printReceipt(config, list);
    }
  }
}
