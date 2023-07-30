import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  final DateTime dateTime;
  final Color textColor;
  final Color backgroundColor;
  final FontWeight fontWeight;

  DayContainer({
    required this.dateTime,
    required this.textColor,
    required this.backgroundColor,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10.0),
      child: Text(
        dateTime.day < 10 ? "0${dateTime.day}" : "${dateTime.day}",
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
