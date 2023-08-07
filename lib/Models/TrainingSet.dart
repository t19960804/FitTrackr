class TrainingSet {
  final int reps;
  final int kg;

  TrainingSet({required this.reps, required this.kg});

  Map<String, dynamic> toMap() {
    return {
      'reps': reps,
      'kg': kg,
    };
  }

  static TrainingSet fromMap(Map<String, dynamic> map) {
    return TrainingSet(
      reps: map['reps'],
      kg: map['kg'],
    );
  }
}
