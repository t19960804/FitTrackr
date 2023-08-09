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
      body: Column(
        children: [
          VolumeGraph(),
          Expanded(
            child: ListView.builder(
              // 在Column裡面使用ListView這種具有無限延展性的Widget，需要用Expanded包住
              itemBuilder: (context, index) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2023-08-09",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "5K",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
