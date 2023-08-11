import 'package:fit_trackr/DatabaseHelper.dart';
import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:flutter/material.dart';
import '../AddSetsPage/SetsList.dart';

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

class _TodayTrainingOptionsListState extends State<TodayTrainingOptionsList> {
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
                  return SetsList(
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
                            color: isSelected ? Colors.black : Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${option.volume}",
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 24,
                            color: isSelected ? Colors.black : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: -10,
                  child: Visibility(
                    visible: widget.isEditMode,
                    child: IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.trainingOptions.remove(option);
                        });
                        DatabaseHelper.getSharedInstance()
                            .deleteTrainingOption(option);
                        print(option.name);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: widget.trainingOptions.length,
      ),
    );
  }
}
