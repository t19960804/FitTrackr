import 'package:fit_trackr/Models/TrainingOption.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class VolumeGraphPage extends StatelessWidget {
  final TrainingOption option;
  final List<PricePoint> points;
  const VolumeGraphPage(
      {super.key, required this.option, required this.points});

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
      body: AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: points
                    .map((point) =>
                        FlSpot(point.x.toDouble(), point.y.toDouble()))
                    .toList(),
                isCurved: true,
                dotData: FlDotData(show: true),
              )
            ],
            // read about it in the LineChartData section
          ),
          duration: Duration(milliseconds: 150), // Optional
          curve: Curves.linear, // Optional
        ),
      ),
    );
  }
}

class PricePoint {
  final int x;
  final int y;

  PricePoint({required this.x, required this.y});

  static List<PricePoint> getPricePoints() {
    const numbers = [99, 88, 77, 66, 55];
    List<PricePoint> result = [];
    for (int i = 0; i < numbers.length; i++) {
      result.add(PricePoint(x: i, y: numbers[i]));
    }
    return result;
  }
}
