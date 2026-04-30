import 'package:flutter/material.dart';
import '../core/user_session.dart';
import '../core/database_helper.dart';
import 'scanner_screen.dart';

class HomeComercianteScreen extends StatefulWidget {
  const HomeComercianteScreen({super.key});

  @override
  State<HomeComercianteScreen> createState() => _HomeComercianteScreenState();
}

class _HomeComercianteScreenState extends State<HomeComercianteScreen> {
  static const _gold = Color(0xFFD4A574);
  static const _green = Color(0xFF00704A);

  int _currentIndex = 0;

  // Páginas do BottomNav
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _PainelTab(gold: _gold, green: _green),
      _ClientesTab(),
      _PontosTab(gold: _gold, green: _green),
      _PremiosTab(),
      _PerfilTab(
        gold: _gold,
        onAccountDeleted: _handleAccountDeleted,
      ),
    ];
  }

  void _handleAccountDeleted() {
    UserSession.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/userType', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: _gold,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Painel"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Clientes"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Pontos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Prêmios"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

// ─── ABA: PAINEL ─────────────────────────────────────────────────────────────

class _PainelTab extends StatelessWidget {
  final Color gold;
  final Color green;

  const _PainelTab({required this.gold, required this.green});

  @override
  Widget build(BuildContext context) {
    final nome = UserSession.userName ?? 'Comerciante';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text("Bem-vindo,",
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            Text(
              nome,
              style: const TextStyle(
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

            // AÇÕES PRINCIPAIS
            Row(
              children: [
                Expanded(
                  child: _actionCard(
                    icon: Icons.qr_code_scanner,
                    title: "Adicionar Pontos",
                    color: green,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ScannerScreen()),
                    ),
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

            // MÉTRICAS
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                MetricCard(title: "Clientes Ativos", value: "147"),
                MetricCard(title: "Pontos Distribuídos", value: "2.345"),
                MetricCard(title: "Resgates Hoje", value: "12"),
                MetricCard(title: "Faturamento", value: "R\$ 8,5k"),
              ],
            ),

            const SizedBox(height: 25),

            // ATIVIDADES RECENTES
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
              descricao: "Ganhou 10 pontos",
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
            Text(title, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

// ─── ABA: CLIENTES ───────────────────────────────────────────────────────────

class _ClientesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          "Lista de clientes\n(em breve)",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ─── ABA: PONTOS (acesso rápido ao scanner) ──────────────────────────────────

class _PontosTab extends StatelessWidget {
  final Color gold;
  final Color green;

  const _PontosTab({required this.gold, required this.green});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Adicionar Pontos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Escaneie o QR Code do cliente para\nadicionar pontos automaticamente.",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScannerScreen()),
              ),
              icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
              label: const Text(
                "Abrir Scanner",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── ABA: PRÊMIOS ─────────────────────────────────────────────────────────────

class _PremiosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          "Gerenciar prêmios\n(em breve)",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ─── ABA: PERFIL ─────────────────────────────────────────────────────────────

class _PerfilTab extends StatefulWidget {
  final Color gold;
  final VoidCallback onAccountDeleted;

  const _PerfilTab({required this.gold, required this.onAccountDeleted});

  @override
  State<_PerfilTab> createState() => _PerfilTabState();
}

class _PerfilTabState extends State<_PerfilTab> {
  final _nomeController = TextEditingController();
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nomeController.text = UserSession.userName ?? '';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    final novoNome = _nomeController.text.trim();
    if (novoNome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O nome não pode ser vazio.")),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await DatabaseHelper().updateUserName(UserSession.userId!, novoNome);
      UserSession.userName = novoNome;
      if (mounted) {
        setState(() => _isEditing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Nome atualizado com sucesso!"),
            backgroundColor: Colors.green.shade700,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao salvar. Tente novamente.")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          "Deletar Conta",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Esta ação é irreversível. Todos os seus dados serão removidos permanentemente.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancelar", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Deletar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await DatabaseHelper().deleteUser(UserSession.userId!);
      widget.onAccountDeleted();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro ao deletar conta.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final nome = UserSession.userName ?? 'Comerciante';
    final gold = widget.gold;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Meu Perfil",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // AVATAR
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: gold.withOpacity(0.2),
                child: Text(
                  nome.isNotEmpty ? nome[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: gold,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // SEÇÃO DE DADOS
            _sectionLabel("Nome"),
            const SizedBox(height: 8),

            if (_isEditing)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nomeController,
                      style: const TextStyle(color: Colors.white),
                      autofocus: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF121212),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: gold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _isSaving
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: gold),
                        )
                      : IconButton(
                          icon: Icon(Icons.check_circle, color: gold),
                          onPressed: _saveName,
                        ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.white38),
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        _nomeController.text = UserSession.userName ?? '';
                      });
                    },
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(
                        nome,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: gold),
                    onPressed: () => setState(() => _isEditing = true),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            _sectionLabel("Tipo de conta"),
            const SizedBox(height: 8),
            _infoTile("Comerciante"),

            const SizedBox(height: 40),

            // BOTÃO DELETAR CONTA
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _confirmDelete,
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                label: const Text(
                  "Deletar Conta",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _infoTile(String value) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white10),
        ),
        child: Text(value, style: const TextStyle(color: Colors.white)),
      );
}

// ─── WIDGETS AUXILIARES ──────────────────────────────────────────────────────

class MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const MetricCard({super.key, required this.title, required this.value});

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
                Text(nome, style: const TextStyle(color: Colors.white)),
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