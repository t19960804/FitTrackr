import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/VolumeGraph/VolumeGraph.dart';

class VolumeGraphPage extends StatelessWidget {
  final TrainingOption option;
  VolumeGraphPage({super.key, required this.option});

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
      body: VolumeGraph(),
    );
  }
}
