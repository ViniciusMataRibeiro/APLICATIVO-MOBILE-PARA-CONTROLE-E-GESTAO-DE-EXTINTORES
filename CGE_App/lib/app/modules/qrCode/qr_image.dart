import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: QrImageView(
          data: "Extintor - 1",
          size: 200,
          embeddedImageStyle: const QrEmbeddedImageStyle(
            size: Size(100, 100),
          ),
        )
      ),
    );
  }
}