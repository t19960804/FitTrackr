import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE persons(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
    );
  }

  static Future<void> insertPerson(Person person) async {
    final db = await database();
    await db.insert(
      'persons',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Person>> fetchPersons() async {
    final db = await database();
    final maps = await db.query('persons');
    return List.generate(maps.length, (i) {
      return Person(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        age: maps[i]['age'] as int,
      );
    });
  }
}

class Person {
  final int? id;
  final String name;
  final int age;

  Person({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
