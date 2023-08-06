import 'package:flutter/material.dart';
import 'SetsAndRepsTextField.dart';
import 'FinishButton.dart';

class AddSetsAndRepsPopView extends StatelessWidget {
  const AddSetsAndRepsPopView({super.key});

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
      child: const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Sets",
              style: TextStyle(
                  color: mainColor, fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Reps",
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SetsAndRepsTextField(),
                    ],
                  ),
                ),
                SizedBox(width: 70),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "KG",
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SetsAndRepsTextField(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            FinishButton(),
          ],
        ),
      ),
    );
  }
}
