class UserSession {
  static String? userType; // 'cliente' ou 'comerciante'
  static int? userId;      // ID que vem do banco após login
  static String? userName; // Nome do usuário logado

  /// Salva os dados do usuário após login ou cadastro bem-sucedido.
  static void save({
    required int id,
    required String nome,
    required String tipo,
  }) {
    userId = id;
    userName = nome;
    userType = tipo;
  }

  /// Limpa a sessão ao fazer logout ou deletar conta.
  static void clear() {
    userId = null;
    userName = null;
    userType = null;
  }
}