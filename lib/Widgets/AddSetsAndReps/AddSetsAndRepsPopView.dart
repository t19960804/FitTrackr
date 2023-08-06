import 'package:flutter/material.dart';
import 'SetsAndRepsTextField.dart';
import 'FinishButton.dart';
import 'package:fit_trackr/Models/TrainingSet.dart';

class AddSetsAndRepsPopView extends StatelessWidget {
  final void Function(TrainingSet) trainingSetWasAdded;
  var _reps = 0;
  var _kg = 0;
  AddSetsAndRepsPopView({super.key, required this.trainingSetWasAdded});

  @override
  Widget build(BuildContext context) {
    const mainColor = Colors.black;

    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add Sets",
              style: TextStyle(
                  color: mainColor, fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Reps",
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SetsAndRepsTextField(
                        onChanged: (value) {
                          _reps = int.parse(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 70),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "KG",
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SetsAndRepsTextField(
                        onChanged: (value) {
                          _kg = int.parse(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            FinishButton(
              onPressed: () {
                final set = TrainingSet(reps: _reps, kg: _kg);
                trainingSetWasAdded(set);
              },
            ),
          ],
        ),
      ),
    );
  }
}
