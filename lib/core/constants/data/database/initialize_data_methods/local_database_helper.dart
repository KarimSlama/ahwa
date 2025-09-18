import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static Database? _database;
  static const String _databaseName = 'ahwa_manager.db';
  static const int _databaseVersion = 1;

  Database get database => _database!;

  Future<Database> initDatabase() async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createTables,
    );
    return _database!;
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE drinks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        price REAL NOT NULL,
        is_available INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id TEXT NOT NULL UNIQUE,
        customer_name TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending',
        notes TEXT,
        total REAL NOT NULL,
        created_at TEXT NOT NULL,
        completed_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        drink_id INTEGER NOT NULL,
        drink_name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unit_price REAL NOT NULL,
        subtotal REAL NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders(id),
        FOREIGN KEY (drink_id) REFERENCES drinks(id)
      )
    ''');

    await _seedData(db);
  }

  Future<void> _seedData(Database db) async {
    final drinks = [
      {
        'name': 'شاي سادة',
        'price': 5.0,
        'is_available': 1,
        'created_at': DateTime.now().toIso8601String()
      },
      {
        'name': 'شاي بالنعناع',
        'price': 7.0,
        'is_available': 1,
        'created_at': DateTime.now().toIso8601String()
      },
      {
        'name': 'قهوة تركي',
        'price': 10.0,
        'is_available': 1,
        'created_at': DateTime.now().toIso8601String()
      },
      {
        'name': 'كركديه',
        'price': 8.0,
        'is_available': 1,
        'created_at': DateTime.now().toIso8601String()
      },
      {
        'name': 'عصير ليمون',
        'price': 12.0,
        'is_available': 1,
        'created_at': DateTime.now().toIso8601String()
      },
    ];

    for (var drink in drinks) {
      await db.insert('drinks', drink);
    }
  }

  Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
  }
}
