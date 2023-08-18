import 'package:cge_app/app/modules/qrCode/generetor/qr_controller_gerenetor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatefulWidget {
  const QRImage({super.key});

  @override
  State<QRImage> createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {
  @override
  Widget build(BuildContext context) {
    QRCodeGeneretorController controller = Get.put(QRCodeGeneretorController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 7, 7),
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
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
          child: QrImageView(
        data: controller.data,
        size: 200,
        embeddedImageStyle: const QrEmbeddedImageStyle(
          size: Size(100, 100),
        ),
      )),
    );
  }
}
