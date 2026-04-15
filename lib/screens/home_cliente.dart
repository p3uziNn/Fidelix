import 'package:flutter/material.dart';

class HomeClienteScreen extends StatelessWidget {
  const HomeClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4A574);
    const green = Color(0xFF00704A);

    // 🔥 dados mock (depois vem Firebase)
    int pontos = 47;
    int meta = 50;

    double progresso = pontos / meta;

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 👋 HEADER
              const Text(
                "Olá,",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const Text(
                "Maria Silva",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // 🪙 CARD DE PONTOS
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Seus Pontos",
                      style: TextStyle(color: Colors.black87),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "$pontos",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Próxima recompensa",
                      style: TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(height: 6),

                    LinearProgressIndicator(
                      value: progresso,
                      backgroundColor: Colors.black12,
                      color: Colors.black,
                      minHeight: 6,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 📊 CARDS MENORES
              Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      title: "Este mês",
                      value: "+23",
                      subtitle: "pontos ganhos",
                      color: green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _infoCard(
                      title: "Resgates",
                      value: "3",
                      subtitle: "recompensas",
                      color: gold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 🎁 RECOMPENSAS
              _sectionTitle("Recompensas em Destaque"),

              const SizedBox(height: 15),

              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    RewardCard(nome: "Café Expresso", pontos: "50 pts"),
                    RewardCard(nome: "Croissant", pontos: "30 pts"),
                    RewardCard(nome: "Desconto 10%", pontos: "100 pts"),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 🏪 LOJAS
              _sectionTitle("Estabelecimentos Parceiros"),

              const SizedBox(height: 15),

              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    "Lista de lojas (em breve)",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // 🔥 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: gold,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Lojas"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Prêmios"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Histórico"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(subtitle, style: const TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Ver todos",
          style: TextStyle(color: Color(0xFFD4A574)),
        )
      ],
    );
  }
}

// 🎁 CARD DE RECOMPENSA
class RewardCard extends StatelessWidget {
  final String nome;
  final String pontos;

  const RewardCard({
    super.key,
    required this.nome,
    required this.pontos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.card_giftcard, color: Colors.white70),
          const SizedBox(height: 10),
          Text(
            nome,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            pontos,
            style: const TextStyle(color: Color(0xFFD4A574)),
          ),
        ],
      ),
    );
  }
}