import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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

              Image.asset(
                'assets/logofidelix.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),

              const SizedBox(height: 10),

              const Text(
                "Fidelidade digital para seu negocio",
                style: TextStyle(color: Colors.blue),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Entrar",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD4A373),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Cadastrar",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              buildInput("Nome completo"),
              buildInput("Email"),
              buildInput("Senha", obscure: true),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A373),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const Spacer(),

              const Text(
                "Já tem conta? Faça login",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput(String label, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: label == "Email" ? "Seu@email.com" : "",
            hintStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}