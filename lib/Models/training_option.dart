import 'training_set.dart';
import 'dart:convert';

class TrainingOption {
  // 在class中宣告一個const屬性, 此時需要加上static
  // 因為const用來宣告編譯時就確定的數值, 加上static後, 在編譯時IDE就能夠從類別直接存取到屬性並儲存
  static const tableName = "options";
  static const fieldOfID = "id";
  static const fieldOfName = "name";
  static const fieldOfVolume = "volume";
  static const fieldOfDateTime = "dateTime";
  static const fieldOfSets = "sets";

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
      fieldOfName: name,
      fieldOfVolume: volume,
      fieldOfDateTime: dateTime,
      fieldOfSets: jsonEncode(sets?.map((set) => set.toMap()).toList()),
    };
  }

  static TrainingOption fromMap(Map<String, dynamic> map) {
    return TrainingOption(
      id: map[fieldOfID] as int,
      name: map[fieldOfName] as String,
      volume: map[fieldOfVolume] as int?,
      dateTime: map[fieldOfDateTime] as String?,
      sets: _parseSets(map[fieldOfSets]),
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

  static String getFormattedVolumeString(TrainingOption option) {
    final volume = option.volume;
    if (volume != null) {
      if (volume >= 1000) {
        return "${volume / 1000}K";
      } else if (volume >= 1000000) {
        return "${volume / 1000000}M";
      } else {
        return "$volume";
      }
    } else {
      return "0";
    }
  }

  static String getFormattedDateTimeString(DateTime dateTime) {
    final yearString = "${dateTime.year}";
    final monthString =
        dateTime.month >= 10 ? dateTime.month : "0${dateTime.month}";
    final dayString = dateTime.day >= 10 ? dateTime.day : "0${dateTime.day}";
    return "$yearString$monthString$dayString";
  }
}
