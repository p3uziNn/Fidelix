import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../core/database_helper.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escanear Cliente", style: TextStyle(color: Colors.white)), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: MobileScanner(
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              int userId = int.parse(barcode.rawValue!);
              // Regra simples: 10 pontos por scan para o teste
              await DatabaseHelper().addPoints(userId, 10);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pontos adicionados com sucesso!")),
                );
                Navigator.pop(context);
              }
              break;
            }
          }
        },
      ),
    );
  }
}