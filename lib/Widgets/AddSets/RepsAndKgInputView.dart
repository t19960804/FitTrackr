import 'package:flutter/material.dart';
import 'IntputTextField.dart';
import 'FinishButton.dart';
import 'package:fit_trackr/Models/TrainingSet.dart';

class RepsAndKgInputView extends StatefulWidget {
  final void Function(TrainingSet) trainingSetWasAdded;
  const RepsAndKgInputView({super.key, required this.trainingSetWasAdded});

  @override
  State<RepsAndKgInputView> createState() => _RepsAndKgInputViewState();
}

class _RepsAndKgInputViewState extends State<RepsAndKgInputView> {
  int? _reps;
  int? _kg;
  var _repsAndKgWasInput = false;

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
                      IntputTextField(
                        onChanged: (value) {
                          if (value == "") {
                            _reps = null;
                          } else {
                            _reps = int.parse(value);
                          }
                          _checkRepsAndKgWasInput();
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
                      IntputTextField(
                        onChanged: (value) {
                          if (value == "") {
                            _kg = null;
                          } else {
                            _kg = int.parse(value);
                          }
                          _checkRepsAndKgWasInput();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            FinishButton(
              canBePressed: _repsAndKgWasInput,
              onPressed: () {
                if (_reps != null && _kg != null) {
                  final set = TrainingSet(reps: _reps!, kg: _kg!);
                  widget.trainingSetWasAdded(set);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _checkRepsAndKgWasInput() {
    setState(() {
      _repsAndKgWasInput = (_reps != null && _kg != null);
    });
  }
}
