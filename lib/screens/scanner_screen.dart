import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../core/database_helper.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _processed = false; // evita processar o mesmo QR duas vezes
  bool _isProcessing = false;

  Future<void> _onDetect(BarcodeCapture capture) async {
    // Evita processar múltiplas leituras simultâneas
    if (_processed || _isProcessing) return;

    final rawValue = capture.barcodes.firstOrNull?.rawValue;

    if (rawValue == null || rawValue.isEmpty) {
      _showFeedback("QR Code inválido ou vazio.", success: false);
      return;
    }

    // Valida que o valor é um ID numérico
    final userId = int.tryParse(rawValue);
    if (userId == null) {
      _showFeedback(
        "QR Code não reconhecido.\nEspera-se o ID do cliente.",
        success: false,
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // Verifica se o usuário existe antes de adicionar pontos
      final user = await DatabaseHelper().getUserById(userId);
      if (user == null) {
        _showFeedback("Cliente não encontrado no sistema.", success: false);
        return;
      }

      await DatabaseHelper().addPoints(userId, 10);

      _processed = true;
      _showFeedback(
        "✓ 10 pontos adicionados para ${user['nome']}!",
        success: true,
        onDone: () => Navigator.pop(context),
      );
    } catch (e) {
      _showFeedback("Erro ao adicionar pontos. Tente novamente.", success: false);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _showFeedback(
    String message, {
    required bool success,
    VoidCallback? onDone,
  }) {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green.shade700 : Colors.red.shade700,
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (onDone != null) {
      Future.delayed(const Duration(seconds: 2), onDone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Escanear Cliente",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: _onDetect),

          // Overlay de carregamento enquanto processa
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFFD4A574)),
              ),
            ),

          // Guia visual de enquadramento
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4A574), width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Instrução
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              "Aponte para o QR Code do cliente",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}