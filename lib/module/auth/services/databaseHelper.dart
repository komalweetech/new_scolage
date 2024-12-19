import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''CREATE TABLE users (
      id $idType,
      role $textType,
      name $textType,
      gender $textType,
      school_name $textType,
      password $textType,
      confirm_password $textType,
      mobile $textType,
      email $textType,
      isLoggedIn $boolType 
    )''');
  }

  Future<void> insertUser(Map<String, dynamic> userData) async {
    final db = await instance.database;
    userData['isLoggedIn'] =  userData['isLoggedIn'] ?? false;
    await db.insert('users', userData,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) {
      return null;
    }
    return result.first;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }
}
