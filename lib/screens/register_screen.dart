
import 'package:flutter/material.dart';
import '../core/user_session.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color fidelixGold = Color(0xFFD4A574);
    const Color fidelixGrey = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // LOGO
                  Image.asset(
                    'assets/logofidelix.png',
                    width: 120,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.stars, color: fidelixGold, size: 80),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Fidelix",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "Fidelidade digital para seu negócio",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  const SizedBox(height: 30),

                  // SWITCH LOGIN/CADASTRO
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: fidelixGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: const Text(
                                "Entrar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: fidelixGold,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Cadastrar",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  buildInput("Nome completo", "Seu nome"),
                  buildInput("Email", "seu@email.com"),
                  buildInput("Senha", "••••••••", obscure: true),

                  const SizedBox(height: 20),

                  // BOTÃO CRIAR CONTA
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        String? type = UserSession.userType;

                        if (type == "cliente") {
                          Navigator.pushReplacementNamed(
                              context, '/homeCliente');
                        } else if (type == "comerciante") {
                          Navigator.pushReplacementNamed(
                              context, '/homeComerciante');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Erro: tipo de usuário não definido"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: fidelixGold,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Criar conta",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // VOLTAR PRO LOGIN
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text.rich(
                      TextSpan(
                        text: "Já tem conta? ",
                        style: TextStyle(color: Colors.white70),
                        children: [
                          TextSpan(
                            text: "Faça login",
                            style: TextStyle(
                              color: fidelixGold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput(String label, String hint, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24),
            filled: true,
            fillColor: const Color(0xFF121212),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD4A574)),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

