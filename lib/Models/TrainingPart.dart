class TrainingPart {
  final String name;
  final List<TrainingOption> options;

  TrainingPart(this.name, this.options);
}

class TrainingOption {
  final String name;
  final int volume;

  TrainingOption(this.name, this.volume);
}
