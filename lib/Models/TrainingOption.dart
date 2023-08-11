import 'TrainingSet.dart';
import 'dart:convert';

class TrainingOption {
  // 在class中宣告一個const屬性, 此時需要加上static
  // 因為const用來宣告編譯時就確定的數值, 加上static後, 在編譯時IDE就能夠從類別直接存取到屬性並儲存
  static const tableName = "options";
  static const field_id = "id";
  static const field_name = "name";
  static const field_volume = "volume";
  static const field_dateTime = "dateTime";
  static const field_sets = "sets";

  int? id; // 主鍵，可以為null，SQLite會自動生成唯一且遞增的id, id不需要在toMap中放入，SQLite會自動生成
  final String name;
  int? volume;
  String? dateTime;
  List<TrainingSet>? sets;

  TrainingOption(
      {this.id, required this.name, this.volume, this.dateTime, this.sets});

  Map<String, dynamic> toMap() {
    //toMap方法將TrainingOption物件轉換為Map<String, dynamic>的格式，以便能夠將它插入到SQLite資料庫中
    return {
      field_name: name,
      field_volume: volume,
      field_dateTime: dateTime,
      field_sets: jsonEncode(sets?.map((set) => set.toMap()).toList()),
    };
  }

  static TrainingOption fromMap(Map<String, dynamic> map) {
    return TrainingOption(
      id: map[field_id] as int,
      name: map[field_name] as String,
      volume: map[field_volume] as int?,
      dateTime: map[field_dateTime] as String?,
      sets: _parseSets(map[field_sets]),
    );
  }

  static List<TrainingSet>? _parseSets(dynamic sets) {
    final List<dynamic>? parsedSets = jsonDecode(sets);
    return parsedSets
        ?.map(
            (setMap) => TrainingSet.fromMap(Map<String, dynamic>.from(setMap)))
        .toList();
  }

  static int calculateVolume(List<TrainingSet> sets) {
    int volume = 0;
    for (var set in sets) {
      volume += set.reps * set.kg;
    }
    return volume;
  }

  static String getFormattedDateTimeString(DateTime dateTime) {
    final yearString = "${dateTime.year}";
    final monthString =
        dateTime.month >= 10 ? dateTime.month : "0${dateTime.month}";
    final dayString = dateTime.day >= 10 ? dateTime.day : "0${dateTime.day}";
    return "$yearString$monthString$dayString";
  }
}
