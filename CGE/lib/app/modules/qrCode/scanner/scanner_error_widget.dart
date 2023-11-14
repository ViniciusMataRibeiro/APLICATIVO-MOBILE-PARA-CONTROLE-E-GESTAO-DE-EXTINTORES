import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({Key? key, required this.error}) : super(key: key);

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Não está pronto.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permissão negada.';
        break;
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'A Leitura de QrCode não é suportada neste dispositivo';
        break;
      default:
        errorMessage = 'Erro genérico';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
