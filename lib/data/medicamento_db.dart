import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'medicamento_model.dart';

class MedicamentoDB {
  static final MedicamentoDB _instance = MedicamentoDB._internal();
  factory MedicamentoDB() => _instance;
  MedicamentoDB._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'medicamentos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE medicamentos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            dosis TEXT,
            frecuencia TEXT,
            hora TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertMedicamento(Medicamento m) async {
    final db = await database;
    return await db.insert('medicamentos', m.toMap());
  }

  Future<List<Medicamento>> getMedicamentos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('medicamentos');
    return maps.map((e) => Medicamento.fromMap(e)).toList();
  }

  Future<int> updateMedicamento(Medicamento m) async {
    final db = await database;
    return await db.update(
      'medicamentos',
      m.toMap(),
      where: 'id = ?',
      whereArgs: [m.id],
    );
  }

  Future<int> deleteMedicamento(int id) async {
    final db = await database;
    return await db.delete('medicamentos', where: 'id = ?', whereArgs: [id]);
  }
}
