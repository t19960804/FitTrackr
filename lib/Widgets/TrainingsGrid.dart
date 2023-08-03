import 'package:flutter/material.dart';
import 'package:fit_trackr/Models/TrainingPart.dart';

class TrainingsGrid extends StatefulWidget {
  var trainingParts = [
    TrainingPart(
      "Chest",
      [
        TrainingOption("Incline Bench Press", 0),
        TrainingOption("Decline Bench Press", 0),
        TrainingOption("Chest Fly", 0),
        TrainingOption("Flat Bench Press", 0),
      ],
    ),
    TrainingPart(
      "Leg",
      [
        TrainingOption("Hack Squat", 0),
        TrainingOption("Leg Curl", 0),
        TrainingOption("Adductor", 0),
        TrainingOption("Leg Extension", 0),
        TrainingOption("RDL", 0),
      ],
    ),
    TrainingPart(
      "Back",
      [
        TrainingOption("Low Back", 0),
        TrainingOption("Wide Lat Pull Down", 0),
        TrainingOption("Narrow Lat Pull Down", 0),
        TrainingOption("Flat Row", 0),
        TrainingOption("Straight arm row", 0),
      ],
    ),
  ];
  var selectStatus = [];
  bool willPop = false;
  void Function(TrainingOption)? optionWasSelected;

  TrainingsGrid(
      {required bool willPop,
      required void Function(TrainingOption) optionWasSelected}) {
    this.willPop = willPop;
    this.optionWasSelected = optionWasSelected;
    _resetSelectStatus();
  }

  void _resetSelectStatus() {
    selectStatus = List.generate(
      trainingParts.length,
      (index) =>
          List.generate(trainingParts[index].options.length, (i) => false),
    );
  }

  @override
  State<TrainingsGrid> createState() => _TrainingsGridState();
}

class _TrainingsGridState extends State<TrainingsGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _HeaderAndCells(widget.trainingParts),
      ),
    );
  }

  List<Widget> _HeaderAndCells(List<TrainingPart> trainingParts) {
    List<Widget> widgets = [];
    for (int i = 0; i < trainingParts.length; i++) {
      final part = trainingParts[i];
      final options = trainingParts[i].options;

      final header = SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: 100, // 設置AppBar展開的高度
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            part.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey),
          ),
        ),
      );
      final cells = SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int j) {
            final isSelected = widget.selectStatus[i][j];
            return TextButton(
              onPressed: () {
                setState(() {
                  widget._resetSelectStatus();
                  widget.selectStatus[i][j] = true;
                });
                widget.optionWasSelected!(options[j]);
                if (widget.willPop) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: isSelected
                      ? null
                      : Border.all(
                          color: Colors.grey,
                          width: 3.0,
                        ),
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  options[j].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            );
          },
          childCount: options.length,
        ),
      );
      widgets.add(header);
      widgets.add(cells);
    }
    return widgets;
  }
}
