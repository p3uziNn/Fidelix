import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Camada de abstração do banco de dados.
/// Para migrar ao Firebase, substitua apenas os métodos abaixo —
/// a UI nunca acessa o banco diretamente.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  // ─── Inicialização ────────────────────────────────────────────────────────

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'fidelix.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id      INTEGER PRIMARY KEY AUTOINCREMENT,
            nome    TEXT    NOT NULL,
            email   TEXT    UNIQUE NOT NULL,
            senha   TEXT    NOT NULL,
            tipo    TEXT    NOT NULL,
            pontos  INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  // ─── Autenticação ─────────────────────────────────────────────────────────

  /// Cadastra um novo usuário. Retorna o ID gerado ou lança exceção em caso
  /// de e-mail duplicado.
  Future<int> registerUser(
    String nome,
    String email,
    String senha,
    String tipo,
  ) async {
    final db = await database;
    return await db.insert(
      'users',
      {'nome': nome, 'email': email, 'senha': senha, 'tipo': tipo, 'pontos': 0},
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  /// Valida e-mail + senha. Retorna o Map do usuário ou null se não encontrado.
  Future<Map<String, dynamic>?> loginUser(String email, String senha) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  // ─── Usuário ──────────────────────────────────────────────────────────────

  /// Busca os dados de um usuário pelo ID.
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// Atualiza o nome do usuário.
  Future<void> updateUserName(int id, String novoNome) async {
    final db = await database;
    await db.update(
      'users',
      {'nome': novoNome},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Remove permanentemente o usuário do banco.
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // ─── Pontos ───────────────────────────────────────────────────────────────

  /// Adiciona pontos ao usuário identificado por [userId].
  Future<void> addPoints(int userId, int pontos) async {
    final db = await database;
    await db.execute(
      'UPDATE users SET pontos = pontos + ? WHERE id = ?',
      [pontos, userId],
    );
  }

  /// Retorna os pontos atuais do usuário.
  Future<int> getPoints(int userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['pontos'],
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (result.isEmpty) return 0;
    return result.first['pontos'] as int;
  }
}