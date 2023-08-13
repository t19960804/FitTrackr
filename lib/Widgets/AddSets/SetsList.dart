import 'package:flutter/material.dart';
import 'package:fit_trackr/Models/TrainingSet.dart';
import 'package:fit_trackr/Widgets/DeleteButton.dart';
import 'package:fit_trackr/Helpers/ShakeAnimationHelper.dart';

class SetsList extends StatelessWidget {
  final ShakeAnimationHelper helper;
  final bool isEditMode;
  final List<TrainingSet> sets;
  final void Function(TrainingSet) deleteButtonTapped;

  const SetsList(
      {super.key,
      required this.helper,
      required this.isEditMode,
      required this.sets,
      required this.deleteButtonTapped});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final trainingSet = sets[index];
        return AnimatedBuilder(
          animation: helper.animation,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: helper.getShakingAngle(isEditMode),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _toOrdinal(index + 1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${trainingSet.reps}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              "reps",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: 40,
                            ),
                            Text(
                              "${trainingSet.kg}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              "kg",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Visibility(
                      visible: isEditMode,
                      child: DeleteButton(onTap: () {
                        deleteButtonTapped(sets[index]);
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      itemCount: sets.length,
    );
  }

  String _toOrdinal(int number) {
    if (number == 0) return "0";

    if (number % 100 == 11 || number % 100 == 12 || number % 100 == 13) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}
