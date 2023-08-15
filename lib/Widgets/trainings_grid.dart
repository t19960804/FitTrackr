import 'package:flutter/material.dart';
import 'package:fit_trackr/Models/training_part.dart';
import 'package:fit_trackr/Models/training_option.dart';
import 'package:fit_trackr/main.dart';
import 'package:fit_trackr/Widgets/VolumeGraph/volume_graph_page.dart';
import 'package:fit_trackr/Helpers/database_helper.dart';

class TrainingsGrid extends StatefulWidget {
  final MainTabType type;
  final void Function(TrainingOption)? optionWasSelected;

  const TrainingsGrid(
      {super.key, required this.type, required this.optionWasSelected});

  @override
  State<TrainingsGrid> createState() => _TrainingsGridState();
}

class _TrainingsGridState extends State<TrainingsGrid> {
  final _trainingParts = [
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
  var _selectStatus = [];

  @override
  void initState() {
    super.initState();
    _resetSelectStatus();
  }

  void _resetSelectStatus() {
    _selectStatus = List.generate(
      _trainingParts.length,
      (index) =>
          List.generate(_trainingParts[index].options.length, (i) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _headerAndCells(_trainingParts),
      ),
    );
  }

  List<Widget> _headerAndCells(List<TrainingPart> trainingParts) {
    List<Widget> widgets = [];
    for (int i = 0; i < trainingParts.length; i++) {
      final part = trainingParts[i];
      final options = trainingParts[i].options;

      final header = SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: 100,
        flexibleSpace: FlexibleSpaceBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 9, top: 35),
              child: Text(
                part.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey),
              ),
            ),
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
            final isSelected = _selectStatus[i][j];
            return TextButton(
              onPressed: () async {
                setState(() {
                  _resetSelectStatus();
                  _selectStatus[i][j] = true;
                });
                widget.optionWasSelected!(options[j]);
                if (widget.type == MainTabType.calender) {
                  Navigator.pop(context);
                } else {
                  final currentTime = DateTime.now();
                  final optionsInCurrentYear =
                      await DatabaseHelper.getSharedInstance()
                          .readTrainingOptions(
                              where: "dateTime LIKE ? AND name LIKE ?",
                              whereArgs: [
                        "%${currentTime.year}%",
                        "%${options[j].name}%"
                      ]);
                  if (context.mounted) {
                    // 用mounted這個屬性, 來確認當前的Widget是否還存在, 避免非同步的操作後, Widget已經不在了, 卻又對它操作
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VolumeGraphPage(
                          navTitle: options[j].name,
                          options: optionsInCurrentYear);
                    }));
                  }
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
