import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/car_model.dart';

class CarDatabase {
  static final CarDatabase instance = CarDatabase._init();

  static Database? _database;
  CarDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('carros.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE carros (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      consumo REAL,
      tanque REAL
    )
    ''');
  }

  Future<int> insertCar(CarModel car) async {
    final db = await instance.database;
    return await db.insert('carros', car.toMap());
  }

  Future<List<CarModel>> getAllCars() async {
    final db = await instance.database;
    final result = await db.query('carros');
    return result.map((map) => CarModel.fromMap(map)).toList();
  }

  Future<int> updateCar(CarModel car) async {
    final db = await instance.database;
    return await db.update('carros', car.toMap(), where: 'id = ?', whereArgs: [car.id]);
  }

  Future<int> deleteCar(int id) async {
    final db = await instance.database;
    return await db.delete('carros', where: 'id = ?', whereArgs: [id]);
  }
}