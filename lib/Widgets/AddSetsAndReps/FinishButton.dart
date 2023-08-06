import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 65,
      child: TextButton(
        onPressed: () {
          // final task = Task(_taskTitle, done: false);
          // final tasksManager =
          // Provider.of<TasksManager>(context, listen: false);
          // tasksManager.addTask(task);
          // Navigator.pop(context); // Dismiss bottom sheet
        },
        child: const Text(
          "Finish",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
