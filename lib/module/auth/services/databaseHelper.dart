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

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String sql = '''
    CREATE TABLE users (
        user_id TEXT PRIMARY KEY,
        role TEXT,
        name TEXT,
        gender TEXT,
        school_name TEXT,
        password TEXT,
        confirm_password TEXT,
        mobile TEXT UNIQUE,
        email TEXT,
        isLoggedIn INTEGER
      )
    ''';
    await db.execute(sql);
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String mobileNumber) async {
    final db = await database;
    final users = await db.query(
      'users',
      where: 'mobile = ?',
      whereArgs: [mobileNumber],
    );
    return users.isNotEmpty ? users.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<int> updateUser(Map<String, dynamic> userData, String userId) async {
    final db = await instance.database;
    return await db.update(
      'users',
      userData,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }


}
