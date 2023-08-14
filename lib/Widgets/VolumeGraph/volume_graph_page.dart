import 'package:fit_trackr/Models/training_option.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/VolumeGraph/volume_graph.dart';

class VolumeGraphPage extends StatelessWidget {
  final String navTitle;
  final List<TrainingOption> options;
  const VolumeGraphPage(
      {super.key, required this.navTitle, required this.options});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          navTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          VolumeGraph(
            options: options,
          ),
          Expanded(
            child: ListView.builder(
              // 在Column裡面使用ListView這種具有無限延展性的Widget，需要用Expanded包住
              itemBuilder: (context, index) {
                final dateTime = options[index].dateTime ?? "unknown";
                final volume =
                    TrainingOption.getFormattedVolumeString(options[index]);

                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 80,
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
                          dateTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          volume,
                          style: const TextStyle(
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
              itemCount: options.length,
            ),
          )
        ],
      ),
    );
  }
}
