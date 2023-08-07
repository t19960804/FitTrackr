import 'package:fit_trackr/Models/TrainingPart.dart';
import 'package:fit_trackr/Models/TrainingSet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  // 在class中宣告一個const屬性, 此時需要加上static
  // 因為const用來宣告編譯時就確定的數值, 加上static後, 在編譯時IDE就能夠從類別直接存取到屬性並儲存
  static const tableName = "options";
  static const field_id = "id";
  static const field_name = "name";
  static const field_volume = "volume";
  static const field_dateTime = "dateTime";
  static const field_sets = "sets";

  DatabaseHelper._();

  factory DatabaseHelper.getSharedInstance() {
    if (_instance == null) {
      _instance = DatabaseHelper._();
    }
    return _instance!;
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
          'CREATE TABLE options($field_id INTEGER PRIMARY KEY, $field_name TEXT, $field_volume INTEGER, $field_dateTime TEXT, $field_sets TEXT)',
        );
      },
    );
  }

  void createTrainingOption(TrainingOption option) async {
    final db = await _database();
    await db.insert(
      tableName,
      option.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TrainingOption>> readTrainingOptions({String? predicate}) async {
    final db = await _database();
    final maps = await db.query(tableName, where: predicate);
    return List.generate(maps.length, (i) {
      return TrainingOption(
          id: maps[i][field_id] as int,
          name: maps[i][field_name] as String,
          volume: maps[i][field_volume] as int?,
          dateTime: maps[i][field_dateTime] as String?,
          sets: _parseSets(maps[i]['sets']));
    });
  }

  static List<TrainingSet>? _parseSets(dynamic sets) {
    final List<dynamic>? parsedSets = jsonDecode(sets);
    return parsedSets
        ?.map(
            (setMap) => TrainingSet.fromMap(Map<String, dynamic>.from(setMap)))
        .toList();
  }

  void updateTrainingOption(TrainingOption option) async {
    final db = await _database();
    await db.update(
      tableName,
      option.toMap(),
      where: '$field_id = ?',
      whereArgs: [option.id],
    );
  }

  void deleteTrainingOption(TrainingOption option) async {
    final db = await _database();
    await db.delete(
      tableName,
      where: '$field_id = ?', // 只更新特定ID的資料
      whereArgs: [option.id], // 提供where中的 ? 的值
    );
  }
}
