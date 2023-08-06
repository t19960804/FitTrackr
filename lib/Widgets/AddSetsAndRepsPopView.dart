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
      height: 350,
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
                      TextField(
                        style: TextStyle(
                          // 控制字体样式
                          fontSize: 25, // 字体大小
                          color: Colors.black, // 字体颜色
                          fontWeight: FontWeight.bold, // 字体粗细
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue), // 文字標籤的顏色
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mainColor, width: 4.0), // 非聚焦時的下劃線顏色和粗度
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mainColor, width: 4.0), // 聚焦時的下劃線顏色和粗度
                          ),
                        ),
                        onChanged: (value) {},
                      ),
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
                      TextField(
                        style: TextStyle(
                          // 控制字体样式
                          fontSize: 25, // 字体大小
                          color: Colors.black, // 字体颜色
                          fontWeight: FontWeight.bold, // 字体粗细
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue), // 文字標籤的顏色
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mainColor, width: 4.0), // 非聚焦時的下劃線顏色和粗度
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mainColor, width: 4.0), // 聚焦時的下劃線顏色和粗度
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: mainColor,
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
                child: Text(
                  "Finish",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
