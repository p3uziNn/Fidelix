import 'package:flutter/material.dart';
import '../core/user_session.dart';
import '../core/database_helper.dart';

class HomeClienteScreen extends StatefulWidget {
  const HomeClienteScreen({super.key});

  @override
  State<HomeClienteScreen> createState() => _HomeClienteScreenState();
}

class _HomeClienteScreenState extends State<HomeClienteScreen> {
  static const _gold = Color(0xFFD4A574);
  static const _green = Color(0xFF00704A);
  static const int _meta = 50;

  int _currentIndex = 0;
  int _pontos = 0;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    final id = UserSession.userId;
    if (id == null) return;
    final pts = await DatabaseHelper().getPoints(id);
    if (mounted) setState(() => _pontos = pts);
  }

  @override
  Widget build(BuildContext context) {
    final nome = UserSession.userName ?? 'Usuário';
    final progresso = (_pontos / _meta).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // HEADER
              const Text(
                "Olá,",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Text(
                nome,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // CARD DE PONTOS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _gold,
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
                      "$_pontos",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Próxima recompensa em ${(_meta - _pontos).clamp(0, _meta)} pts",
                      style: const TextStyle(color: Colors.black54),
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

              // CARDS MENORES
              Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      title: "Este mês",
                      value: "+23",
                      subtitle: "pontos ganhos",
                      color: _green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _infoCard(
                      title: "Resgates",
                      value: "3",
                      subtitle: "recompensas",
                      color: _gold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // RECOMPENSAS
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

              // LOJAS
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

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: _gold,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Lojas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Prêmios"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Histórico"),
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
        const Text("Ver todos", style: TextStyle(color: _gold)),
      ],
    );
  }
}

class RewardCard extends StatelessWidget {
  final String nome;
  final String pontos;

  const RewardCard({super.key, required this.nome, required this.pontos});

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
          Text(pontos, style: const TextStyle(color: Color(0xFFD4A574))),
        ],
      ),
    );
  }
}