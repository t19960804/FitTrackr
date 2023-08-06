import 'package:flutter/material.dart';

class SetsAndRepsList extends StatefulWidget {
  final String navTitle;
  SetsAndRepsList({required this.navTitle});

  @override
  State<SetsAndRepsList> createState() => _SetsAndRepsListState();
}

class _SetsAndRepsListState extends State<SetsAndRepsList> {
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
                  onPressed: () {},
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
    );
  }
}
