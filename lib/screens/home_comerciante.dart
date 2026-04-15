import 'package:flutter/material.dart';

class HomeComercianteScreen extends StatelessWidget {
  const HomeComercianteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4A574);
    const green = Color(0xFF00704A);

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
                "Bem-vindo,",
                style: TextStyle(color: Colors.white70),
              ),

              const Text(
                "Padaria do Bairro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                "Seu painel de controle",
                style: TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 25),

              // 🔥 AÇÕES PRINCIPAIS
              Row(
                children: [
                  Expanded(
                    child: _actionCard(
                      icon: Icons.add,
                      title: "Adicionar Pontos",
                      color: green,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _actionCard(
                      icon: Icons.group,
                      title: "Ver Clientes",
                      color: gold,
                      onTap: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 📊 MÉTRICAS
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  MetricCard(title: "Clientes Ativos", value: "147"),
                  MetricCard(title: "Pontos Distribuídos", value: "2,345"),
                  MetricCard(title: "Resgates Hoje", value: "12"),
                  MetricCard(title: "Faturamento", value: "R\$ 8.5k"),
                ],
              ),

              const SizedBox(height: 25),

              // 🕒 ATIVIDADES
              const Text(
                "Atividades Recentes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const ActivityTile(
                nome: "João Silva",
                descricao: "Ganhou 5 pontos",
                tempo: "5 min atrás",
              ),

              const ActivityTile(
                nome: "Maria Santos",
                descricao: "Resgatou 1 café",
                tempo: "12 min atrás",
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
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Painel"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Clientes"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Pontos"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Prêmios"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Relatórios"),
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// 📊 CARD DE MÉTRICA
class MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// 🕒 ATIVIDADE
class ActivityTile extends StatelessWidget {
  final String nome;
  final String descricao;
  final String tempo;

  const ActivityTile({
    super.key,
    required this.nome,
    required this.descricao,
    required this.tempo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF00704A),
            child: Icon(Icons.trending_up, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome,
                    style: const TextStyle(color: Colors.white)),
                Text(descricao,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Text(
            tempo,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}