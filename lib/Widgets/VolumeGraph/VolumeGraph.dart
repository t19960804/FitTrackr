import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fit_trackr/Models/TrainingOption.dart';

class VolumeGraph extends StatelessWidget {
  final _lineColor = Colors.black.withOpacity(0.5);
  List<TrainingOption> options;
  Map<int, List<TrainingOption>> resultMap = {};

  VolumeGraph({super.key, required this.options}) {
    for (var option in options) {
      if (option.dateTime != null && option.dateTime!.length >= 6) {
        var month = int.parse(option.dateTime!.substring(4, 6));

        // If the key (month) doesn't exist in the map, create an empty list for it
        resultMap[month] ??= [];

        // Add the TrainingOption to the list corresponding to the month
        resultMap[month]!.add(option);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          mainData(gradientColors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary
          ]),
        ),
      ),
    );
  }

  LineChartData mainData({required List<Color> gradientColors}) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: _lineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: _lineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: _lineColor),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 0),
            FlSpot(1, getTotalVolume(resultMap[1])),
            FlSpot(2, getTotalVolume(resultMap[2])),
            FlSpot(3, getTotalVolume(resultMap[3])),
            FlSpot(4, getTotalVolume(resultMap[4])),
            FlSpot(5, getTotalVolume(resultMap[5])),
            FlSpot(6, getTotalVolume(resultMap[6])),
            FlSpot(7, getTotalVolume(resultMap[7])),
            FlSpot(8, getTotalVolume(resultMap[8])),
            FlSpot(9, getTotalVolume(resultMap[9])),
            FlSpot(10, getTotalVolume(resultMap[10])),
            FlSpot(11, getTotalVolume(resultMap[11])),
            FlSpot(12, getTotalVolume(resultMap[12])),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    switch (value.toInt()) {
      case 3:
        text = const Text('MAR', style: style);
        break;
      case 6:
        text = const Text('JUN', style: style);
        break;
      case 9:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  double getTotalVolume(List<TrainingOption>? options) {
    if (options == null) {
      return 0;
    }
    var sum = 0;
    for (var option in options) {
      sum += option.volume ?? 0;
    }
    return sum / 10000;
  }
}
