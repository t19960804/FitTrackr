import 'package:fit_trackr/Models/TrainingSet.dart';
import 'package:fit_trackr/Widgets/AddSetsAndReps/AddSetsAndRepsPopView.dart';
import 'package:flutter/material.dart';

class SetsAndRepsList extends StatefulWidget {
  final String navTitle;
  SetsAndRepsList({required this.navTitle});

  @override
  State<SetsAndRepsList> createState() => _SetsAndRepsListState();
}

class _SetsAndRepsListState extends State<SetsAndRepsList> {
  List<TrainingSet> _trainingSets = [];
  var _isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.navTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: _isEditMode
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context)
                                    .viewInsets
                                    .bottom), // 用MediaQuery去讀取裝置的數據
                            decoration: const BoxDecoration(
                              color: Color(0xff757575),
                            ),
                            child: AddSetsAndRepsPopView(
                              trainingSetWasAdded: (set) {
                                setState(() {
                                  _trainingSets.add(set);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : null,
          actions: [
            IconButton(
              icon: Icon(_isEditMode ? Icons.done : Icons.edit),
              onPressed: () {
                setState(() {
                  if (_isEditMode == true) {
                    _isEditMode = false;
                  } else {
                    _isEditMode = true;
                  }
                });
              },
            ),
          ]),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final trainingSet = _trainingSets[index];
          return Container(
            margin: const EdgeInsets.all(10),
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
                    "1st",
                    style: TextStyle(
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
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
          );
        },
        itemCount: _trainingSets.length,
      ),
    );
  }
}
