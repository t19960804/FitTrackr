import 'package:fit_trackr/Helpers/AlertHelper.dart';
import 'package:fit_trackr/Helpers/DatabaseHelper.dart';
import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:fit_trackr/Widgets/DeleteButton.dart';
import 'package:flutter/material.dart';
import '../AddSets/AddSetsPage.dart';
import 'package:fit_trackr/Helpers/ShakeAnimationHelper.dart';

class TodayTrainingOptionsList extends StatefulWidget {
  var trainingOptions = [];
  var selectStatus = [];
  var isEditMode = false;

  TodayTrainingOptionsList(
      List<TrainingOption> trainingOptions, bool isEditMode) {
    this.trainingOptions = trainingOptions;
    this.selectStatus = List.generate(trainingOptions.length, (index) => false);
    this.isEditMode = isEditMode;
  }

  @override
  State<TodayTrainingOptionsList> createState() =>
      _TodayTrainingOptionsListState();
}

class _TodayTrainingOptionsListState extends State<TodayTrainingOptionsList>
    with TickerProviderStateMixin {
  late ShakeAnimationHelper helper;

  @override
  void initState() {
    super.initState();
    helper = ShakeAnimationHelper(provider: this);
    helper.stop();
  }

  @override
  void didUpdateWidget(TodayTrainingOptionsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEditMode == true) {
      helper.start();
    } else {
      helper.stop();
    }
  }

  @override
  void dispose() {
    helper.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // 在Column裡面使用ListView這種具有無限延展性的Widget，需要用Expanded包住
        itemBuilder: (context, index) {
          final option = widget.trainingOptions[index];
          final isSelected = widget.selectStatus[index];

          return TextButton(
            onPressed: () {
              setState(() {
                widget.selectStatus
                    .fillRange(0, widget.selectStatus.length, false);
                widget.selectStatus[index] = true;

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddSetsPage(
                    option: option,
                    setsWasUpdated: () {
                      setState(() {
                        print("Sets update");
                      });
                    },
                  );
                }));
              });
            },
            child: AnimatedBuilder(
              animation: helper.animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: helper.getShakingAngle(widget.isEditMode),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 80,
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            children: [
                              Text(
                                option.name,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 24,
                                  color:
                                      isSelected ? Colors.black : Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${option.volume ?? 0}",
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 24,
                                  color:
                                      isSelected ? Colors.black : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Visibility(
                          visible: widget.isEditMode,
                          child: DeleteButton(
                            onTap: () {
                              AlertHelper.showAlert(context, deleteAction: () {
                                setState(() {
                                  widget.trainingOptions.remove(option);
                                });
                                DatabaseHelper.getSharedInstance()
                                    .deleteTrainingOption(option);
                                Navigator.of(context).pop();
                              }, cancelAction: () {
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        itemCount: widget.trainingOptions.length,
      ),
    );
  }
}
