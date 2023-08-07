import 'TrainingSet.dart';
import 'dart:convert';

class TrainingPart {
  final String name;
  final List<TrainingOption> options;

  TrainingPart(this.name, this.options);
}

class TrainingOption {
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
      'name': name,
      'volume': volume,
      'dateTime': dateTime,
      'sets': jsonEncode(sets?.map((set) => set.toMap()).toList()),
    };
  }

  static TrainingOption fromMap(Map<String, dynamic> map) {
    return TrainingOption(
      id: map["id"] as int,
      name: map['name'] as String,
      volume: map['volume'] as int?,
      dateTime: map['dateTime'] as String?,
      sets: jsonDecode(map['sets'])
          ?.map((setMap) =>
              TrainingSet.fromMap(Map<String, dynamic>.from(setMap)))
          .toList() as List<TrainingSet>?,
    );
  }
}
