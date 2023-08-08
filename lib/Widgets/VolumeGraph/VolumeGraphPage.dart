import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:flutter/material.dart';

class VolumeGraphPage extends StatelessWidget {
  final TrainingOption option;
  const VolumeGraphPage({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          option.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Text("456"),
    );
  }
}
