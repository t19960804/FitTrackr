import 'package:flutter/material.dart';
import 'package:fit_trackr/Models/TrainingPart.dart';
import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:fit_trackr/main.dart';
import 'package:fit_trackr/Widgets/VolumeGraph/VolumeGraphPage.dart';

class TrainingsGrid extends StatefulWidget {
  var trainingParts = [
    TrainingPart(
      "Chest",
      [
        TrainingOption(name: "Incline Bench Press"),
        TrainingOption(name: "Decline Bench Press"),
        TrainingOption(name: "Chest Fly"),
        TrainingOption(name: "Flat Bench Press"),
      ],
    ),
    TrainingPart(
      "Leg",
      [
        TrainingOption(name: "Hack Squat"),
        TrainingOption(name: "Leg Curl"),
        TrainingOption(name: "Adductor"),
        TrainingOption(name: "Leg Extension"),
        TrainingOption(name: "RDL"),
      ],
    ),
    TrainingPart(
      "Back",
      [
        TrainingOption(name: "Low Back"),
        TrainingOption(name: "Wide Lat Pull Down"),
        TrainingOption(name: "Narrow Lat Pull Down"),
        TrainingOption(name: "Flat Row"),
        TrainingOption(name: "Straight arm row"),
      ],
    ),
  ];
  var selectStatus = [];
  var type = MainTabType.calender;
  void Function(TrainingOption)? optionWasSelected;

  TrainingsGrid(
      {required MainTabType type,
      required void Function(TrainingOption) optionWasSelected}) {
    this.type = type;
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
                if (widget.type == MainTabType.calender) {
                  Navigator.pop(context);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VolumeGraphPage(
                      option: options[j],
                      points: PricePoint.getPricePoints(),
                    );
                  }));
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
