import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:fit_trackr/Models/TrainingSet.dart';
import 'package:fit_trackr/Widgets/AddSetsPage/RepsAndKgInputView.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/DatabaseHelper.dart';

class SetsList extends StatefulWidget {
  final TrainingOption option;
  final void Function() _setsWasUpdated;

  List<TrainingSet> _trainingSets = [];

  SetsList({required this.option, required void Function() setsWasUpdated})
      : _setsWasUpdated = setsWasUpdated {
    _trainingSets = option.sets ?? [];
  }

  @override
  State<SetsList> createState() => _SetsListState();
}

class _SetsListState extends State<SetsList> {
  var _isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.option.name,
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
                            child: RepsAndKgInputView(
                              trainingSetWasAdded: (set) async {
                                setState(() {
                                  widget._trainingSets.add(set);
                                });
                                widget.option.sets = widget._trainingSets;
                                widget.option.volume =
                                    TrainingOption.calculateVolume(
                                        widget.option.sets!);
                                DatabaseHelper.getSharedInstance()
                                    .updateTrainingOption(widget.option);
                                widget._setsWasUpdated();
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
          final trainingSet = widget._trainingSets[index];
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
                    _toOrdinal(index + 1),
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
        itemCount: widget._trainingSets.length,
      ),
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
