import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../core/user_session.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // LOGO
              Center(
                child: Image.asset(
                  'assets/logofidelix.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),

              const SizedBox(height: 30),

              // BOTÕES ENTRAR / CADASTRAR
              Row(
                children: [
                  // ENTRAR (ativo)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A373),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // CADASTRAR (CLICÁVEL)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // EMAIL
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: TextStyle(color: Colors.white)),
              ),

              const SizedBox(height: 5),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Seu@email.com",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // SENHA
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Senha", style: TextStyle(color: Colors.white)),
              ),

              const SizedBox(height: 5),

              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "••••••••",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ESQUECEU SENHA
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // futuramente reset senha
                  },
                  child: const Text(
                    "Esqueceu a senha?",
                    style: TextStyle(color: Color(0xFFD4A373)),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // BOTÃO ENTRAR (CLICÁVEL)
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (UserSession.userType == "cliente") {
                    Navigator.pushReplacementNamed(context, '/homeCliente');
                  } else if (UserSession.userType == "comerciante") {
                    Navigator.pushReplacementNamed(context, '/homeComerciante');
                  } else {
                    // caso dê algum bug (não escolheu tipo)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Erro: tipo de usuário não definido"),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A373),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // CADASTRE-SE (CLICÁVEL)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Não tem conta? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: "Cadastre-se",
                        style: TextStyle(color: Color(0xFFD4A373)),
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
    );
  }
}
