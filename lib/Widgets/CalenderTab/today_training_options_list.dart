import 'package:fit_trackr/Helpers/alert_helper.dart';
import 'package:fit_trackr/Helpers/database_helper.dart';
import 'package:fit_trackr/Models/training_option.dart';
import 'package:fit_trackr/Widgets/delete_button.dart';
import 'package:flutter/material.dart';
import '../AddSets/add_sets_page.dart';
import 'package:fit_trackr/Widgets/Animation/shake_animation_widget.dart';

class TodayTrainingOptionsList extends StatefulWidget {
  final List<TrainingOption> trainingOptions;
  final bool isEditMode;
  var selectStatus = [];

  TodayTrainingOptionsList(
      {super.key, required this.trainingOptions, required this.isEditMode}) {
    selectStatus = List.generate(trainingOptions.length, (index) => false);
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
                  return AddSetsPage(
                    option: option,
                    setsWasUpdated: () {
                      setState(() {});
                    },
                  );
                }));
              });
            },
            child: ShakeAnimationWidget(
              isShaking: widget.isEditMode,
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
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            TrainingOption.getFormattedVolumeString(option),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: isSelected ? Colors.black : Colors.grey,
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
            ),
          );
        },
        itemCount: widget.trainingOptions.length,
      ),
    );
  }
}
