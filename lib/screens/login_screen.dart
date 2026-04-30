import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../core/user_session.dart';
import '../core/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isLoading = false;

  static const _gold = Color(0xFFD4A373);

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final senha = _senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      _showSnack("Preencha e-mail e senha.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await DatabaseHelper().loginUser(email, senha);

      if (!mounted) return;

      if (user == null) {
        _showSnack("E-mail ou senha incorretos.");
        return;
      }

      // Salva a sessão com os dados vindos do banco
      UserSession.save(
        id: user['id'] as int,
        nome: user['nome'] as String,
        tipo: user['tipo'] as String,
      );

      final route = UserSession.userType == 'cliente'
          ? '/homeCliente'
          : '/homeComerciante';

      Navigator.pushReplacementNamed(context, route);
    } catch (e) {
      _showSnack("Erro inesperado. Tente novamente.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red.shade700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Garante que o layout sobe quando o teclado aparece
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // LOGO
              Center(
                child: Image.asset(
                  'assets/logofidelix.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.stars, color: _gold, size: 80),
                ),
              ),

              const SizedBox(height: 30),

              // SWITCH ENTRAR / CADASTRAR
              Row(
                children: [
                  // ENTRAR (ativo)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _gold,
                        borderRadius: BorderRadius.circular(10),
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

                  const SizedBox(width: 10),

                  // CADASTRAR
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      ),
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

              const SizedBox(height: 30),

              // EMAIL
              _buildLabel("Email"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _emailController,
                hint: "seu@email.com",
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 15),

              // SENHA
              _buildLabel("Senha"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _senhaController,
                hint: "••••••••",
                obscure: true,
              ),

              const SizedBox(height: 8),

              // ESQUECEU SENHA
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: implementar reset de senha
                  },
                  child: const Text(
                    "Esqueceu a senha?",
                    style: TextStyle(color: _gold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // BOTÃO ENTRAR
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              // CADASTRE-SE
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Não tem conta? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: "Cadastre-se",
                        style: TextStyle(color: _gold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF121212),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _gold),
        ),
      ),
    );
  }
}