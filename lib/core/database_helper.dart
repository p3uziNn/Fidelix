import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fidelix.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            email TEXT UNIQUE,
            senha TEXT,
            tipo TEXT,
            pontos INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  // Cadastro
  Future<int> registerUser(String nome, String email, String senha, String tipo) async {
    final db = await database;
    return await db.insert('users', {
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
      'pontos': 0
    });
  }

  // Login
  Future<Map<String, dynamic>?> loginUser(String email, String senha) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // Adicionar Pontos
  Future<void> addPoints(int userId, int pontos) async {
    final db = await database;
    await db.execute(
      'UPDATE users SET pontos = pontos + ? WHERE id = ?',
      [pontos, userId],
    );
  }
}