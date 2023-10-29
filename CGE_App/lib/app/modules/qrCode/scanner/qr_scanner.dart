import 'package:cge_app/app/modules/qrCode/scanner/scanner_error_widget.dart';
import 'package:cge_app/app/modules/qrCode/scanner/qr_controller.dart';
import 'package:cge_app/app/modules/qrCode/scanner/qr_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner>
    with SingleTickerProviderStateMixin {
  QRCodeScannerController controller = QRCodeScannerController();

  void closeScreen() {
    controller.isScanComplete = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Coloque o QRCode na área',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'O QRCode será escaneado automaticamente',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    startDelay: false,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, child) {
                      return ScannerErrorWidget(error: error);
                    },
                    onDetect: (capture) async {
                      await controller
                              .verificaQrCode(capture.barcodes.first.rawValue);
                    },
                  ),
                  const QRScannerOverlay(overlayColour: bgColor),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Aguardando QRCode...',
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 1, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
