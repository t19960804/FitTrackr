import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;

  DatabaseHelper._();

  factory DatabaseHelper.getSharedInstance() {
    return _instance ??= DatabaseHelper._();
  }

  Future<Database> _database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          // 把table想像成一個國家, table中的每一行資料想像成一個人民, primary key就是人民獨一無二的身分證
          // SQLite 只有四種基本資料類型：INTEGER、REAL、TEXT 和BLOB, 如果要儲存陣列, 需要轉字串
          'CREATE TABLE ${TrainingOption.tableName}(${TrainingOption.fieldOfID} INTEGER PRIMARY KEY, ${TrainingOption.fieldOfName} TEXT, ${TrainingOption.fieldOfVolume} INTEGER, ${TrainingOption.fieldOfDateTime} TEXT, ${TrainingOption.fieldOfSets} TEXT)',
        );
      },
    );
  }

  void createTrainingOption(TrainingOption option) async {
    final db = await _database();
    await db.insert(
      TrainingOption.tableName,
      option.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TrainingOption>> readTrainingOptions(
      {String? where, List<String>? whereArgs}) async {
    final db = await _database();
    final maps = await db.query(TrainingOption.tableName,
        where: where, whereArgs: whereArgs);
    return List.generate(maps.length, (i) {
      return TrainingOption.fromMap(maps[i]);
    });
  }

  void updateTrainingOption(TrainingOption option) async {
    final db = await _database();
    await db.update(
      TrainingOption.tableName,
      option.toMap(),
      where: '${TrainingOption.fieldOfID} = ?',
      whereArgs: [option.id],
    );
  }

  void deleteTrainingOption(TrainingOption option) async {
    final db = await _database();
    await db.delete(
      TrainingOption.tableName,
      where: '${TrainingOption.fieldOfID} = ?', // 只更新特定ID的資料
      whereArgs: [option.id], // 提供where中的 ? 的值
    );
  }
}
