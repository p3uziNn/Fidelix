import 'package:flutter/material.dart';
import '../core/user_session.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Título
              const Text(
                "Bem-vindo!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Como você deseja usar o Fidelix?",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 40),

              // Card Cliente
              _buildCard(
                context,
                icon: Icons.person_outline,
                title: "Sou Cliente",
                description:
                    "Acumule pontos em suas compras e troque por recompensas",
                color: const Color(0xFFD4A574),
                onTap: () {
                  UserSession.userType = "cliente";
                  Navigator.pushNamed(context, '/login');
                },
              ),

              const SizedBox(height: 20),

              // Card Comerciante
              _buildCard(
                context,
                icon: Icons.storefront_outlined,
                title: "Sou Comerciante",
                description:
                    "Gerencie seu programa de fidelidade e fidelize seus clientes",
                color: const Color(0xFF00704A),
                onTap: () {
                  UserSession.userType = "comerciante";
                  Navigator.pushNamed(context, '/login');
                },
              ),

              const Spacer(),

              // Texto rodapé
              const Center(
                child: Text(
                  "Você poderá alterar isso depois nas configurações",
                  style: TextStyle(color: Colors.white38, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.grey.shade900, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),

            const SizedBox(height: 20),

            // Título
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Descrição
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 16),

            // Botão
            Row(
              children: [
                Text(
                  "Começar",
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.arrow_forward, color: color, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
