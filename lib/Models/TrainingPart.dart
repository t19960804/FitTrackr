class TrainingPart {
  final String name;
  final List<TrainingOption> options;

  TrainingPart(this.name, this.options);
}

class TrainingOption {
  int? id; // 主鍵，可以為null，SQLite會自動生成唯一且遞增的id, id不需要在toMap中放入，SQLite會自動生成
  final String name;
  int? volume;
  final String? dateTime;

  TrainingOption({this.id, required this.name, this.volume, this.dateTime});

  Map<String, dynamic> toMap() {
    //toMap方法將TrainingOption物件轉換為Map<String, dynamic>的格式，以便能夠將它插入到SQLite資料庫中
    return {
      'name': name,
      'volume': volume,
      'dateTime': dateTime,
    };
  }
}
