import 'package:flutter/material.dart';

class AddSetsAndRepsPopView extends StatefulWidget {
  @override
  State<AddSetsAndRepsPopView> createState() => _AddSetsAndRepsPopViewState();
}

class _AddSetsAndRepsPopViewState extends State<AddSetsAndRepsPopView> {
  @override
  Widget build(BuildContext context) {
    const mainColor = Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Task",
              style: TextStyle(
                  color: mainColor, fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.blue), // 文字標籤的顏色
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: mainColor, width: 4.0), // 非聚焦時的下劃線顏色和粗度
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: mainColor, width: 4.0), // 聚焦時的下劃線顏色和粗度
                ),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 30),
            Container(
              height: 65,
              color: mainColor,
              child: TextButton(
                onPressed: () {
                  // final task = Task(_taskTitle, done: false);
                  // final tasksManager =
                  // Provider.of<TasksManager>(context, listen: false);
                  // tasksManager.addTask(task);
                  // Navigator.pop(context); // Dismiss bottom sheet
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
