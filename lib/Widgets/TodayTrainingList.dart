import 'package:flutter/material.dart';

class TodayTrainingList extends StatefulWidget {
  var training = [];
  var selectStatus = [];

  TodayTrainingList(List<String> training) {
    this.training = training;
    this.selectStatus = List.generate(training.length, (index) => false);
  }

  @override
  State<TodayTrainingList> createState() => _TodayTrainingListState();
}

class _TodayTrainingListState extends State<TodayTrainingList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // 在Column裡面使用ListView這種具有無限延展性的Widget，需要用Expanded包住
        itemBuilder: (context, index) {
          final training = widget.training[index];
          final isSelected = widget.selectStatus[index];

          return TextButton(
            onPressed: () {
              setState(() {
                widget.selectStatus
                    .fillRange(0, widget.selectStatus.length, false);
                widget.selectStatus[index] = true;

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Text("$training");
                }));
              });
            },
            child: Container(
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
                      training,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 24,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "2K",
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 24,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: widget.training.length,
      ),
    );
  }
}
