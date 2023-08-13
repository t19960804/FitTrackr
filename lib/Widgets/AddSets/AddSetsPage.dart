import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:fit_trackr/Models/TrainingSet.dart';
import 'package:fit_trackr/Widgets/AddSets/RepsAndKgInputView.dart';
import 'package:fit_trackr/Widgets/AddSets/SetsList.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/Helpers/DatabaseHelper.dart';
import 'package:fit_trackr/Helpers/AlertHelper.dart';
import 'package:fit_trackr/Helpers/ShakeAnimationHelper.dart';

class AddSetsPage extends StatefulWidget {
  final TrainingOption option;
  final void Function() _setsWasUpdated;

  List<TrainingSet> _trainingSets = [];

  AddSetsPage({required this.option, required void Function() setsWasUpdated})
      : _setsWasUpdated = setsWasUpdated {
    _trainingSets = option.sets ?? [];
  }

  @override
  State<AddSetsPage> createState() => _AddSetsPageState();
}

class _AddSetsPageState extends State<AddSetsPage>
    with TickerProviderStateMixin {
  late ShakeAnimationHelper helper;
  var _isEditMode = false;

  @override
  void initState() {
    super.initState();
    helper = ShakeAnimationHelper(provider: this);
  }

  @override
  void dispose() {
    helper.controller.dispose();
    super.dispose();
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
                                  widget._trainingSets.add(set);
                                });
                                updateTrainingOptionInDB();
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
                    helper.stop();
                  } else {
                    _isEditMode = true;
                    helper.start();
                  }
                });
              },
            ),
          ]),
      body: SetsList(
        helper: helper,
        isEditMode: _isEditMode,
        sets: widget._trainingSets,
        deleteButtonTapped: (trainingSet) {
          AlertHelper.showAlert(context, deleteAction: () {
            setState(() {
              widget._trainingSets.remove(trainingSet);
            });
            updateTrainingOptionInDB();
            widget._setsWasUpdated();
            Navigator.of(context).pop();
          }, cancelAction: () {
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }

  void updateTrainingOptionInDB() {
    widget.option.sets = widget._trainingSets;
    widget.option.volume = TrainingOption.calculateVolume(widget.option.sets!);
    DatabaseHelper.getSharedInstance().updateTrainingOption(widget.option);
  }
}
