import 'package:fit_trackr/Models/training_option.dart';
import 'package:fit_trackr/Models/training_set.dart';
import 'package:fit_trackr/Widgets/AddSets/reps_kg_input_view.dart';
import 'package:fit_trackr/Widgets/AddSets/sets_list.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/Helpers/database_helper.dart';
import 'package:fit_trackr/Helpers/alert_helper.dart';

class AddSetsPage extends StatefulWidget {
  final TrainingOption option;
  final void Function() setsWasUpdated;
  const AddSetsPage(
      {super.key, required this.option, required this.setsWasUpdated});

  @override
  State<AddSetsPage> createState() => _AddSetsPageState();
}

class _AddSetsPageState extends State<AddSetsPage> {
  List<TrainingSet> _trainingSets = [];
  var _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _trainingSets = widget.option.sets ?? [];
  }

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
                                  _trainingSets.add(set);
                                });
                                updateTrainingOptionInDB();
                                widget.setsWasUpdated();
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
      body: SetsList(
        isEditMode: _isEditMode,
        sets: _trainingSets,
        deleteButtonTapped: (trainingSet) {
          AlertHelper.showAlert(context, deleteAction: () {
            setState(() {
              _trainingSets.remove(trainingSet);
            });
            updateTrainingOptionInDB();
            widget.setsWasUpdated();
            Navigator.of(context).pop();
          }, cancelAction: () {
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }

  void updateTrainingOptionInDB() {
    widget.option.sets = _trainingSets;
    widget.option.volume = TrainingOption.calculateVolume(widget.option.sets!);
    DatabaseHelper.getSharedInstance().updateTrainingOption(widget.option);
  }
}
