import 'package:flutter/material.dart';
import 'package:fit_trackr/Models/Training.dart';

class TrainingsGrid extends StatefulWidget {
  var trainings = [
    Training(
      "Chest",
      [
        "Incline Bench Press",
        "Decline Bench Press",
        "Chest Fly",
        "Flat Bench Press",
      ],
    ),
    Training(
      "Leg",
      [
        "Hack Squat",
        "Leg Curl",
        "Adductor",
        "Leg Extension",
        "RDL",
      ],
    ),
    Training(
      "Back",
      [
        "Low Back",
        "Wide Lat Pull Down",
        "Narrow Lat Pull Down",
        "Leg Extension",
        "Straight arm row",
      ],
    ),
  ];
  var selectStatus = [];

  TrainingsGrid() {
    _resetSelectStatus();
  }

  void _resetSelectStatus() {
    selectStatus = List.generate(
      trainings.length,
      (index) => List.generate(trainings[index].options.length, (i) => false),
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
        slivers: _HeaderAndCells(widget.trainings),
      ),
    );
  }

  List<Widget> _HeaderAndCells(List<Training> trainings) {
    List<Widget> widgets = [];
    for (int i = 0; i < trainings.length; i++) {
      final part = trainings[i].part;
      final options = trainings[i].options;

      final header = SliverAppBar(
        expandedHeight: 100, // 設置AppBar展開的高度
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            part,
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
                  print(options[j]);
                });
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
                  options[j],
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
