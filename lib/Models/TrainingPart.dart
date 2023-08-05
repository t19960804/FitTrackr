class TrainingPart {
  final String name;
  final List<TrainingOption> options;

  TrainingPart(this.name, this.options);
}

class TrainingOption {
  int? id; // 主鍵，可以為null，SQLite會自動生成唯一且遞增的id
  final String name;
  int? volume;
  final String? dateTime;

  TrainingOption({this.id, required this.name, this.volume, this.dateTime});

  //toMap方法將TrainingOption物件轉換為Map<String, dynamic>的格式，以便能夠將它插入到SQLite資料庫中
  Map<String, dynamic> toMap() {
    return {
      // 'id'欄位不需要在toMap中放入，SQLite會自動生成
      'name': name,
      'volume': volume,
      'dateTime': dateTime,
    };
  }
}
