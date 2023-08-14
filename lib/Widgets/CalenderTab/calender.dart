import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'day_container.dart';

class Calendar extends StatefulWidget {
  void Function(DateTime) onDaySelected;
  Calendar({super.key, required this.onDaySelected});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
        });
        widget.onDaySelected(_selectedDay);
      },
      calendarBuilders: CalendarBuilders(
        outsideBuilder: (context, currentTime, previousTime) {
          return Center(
            child: DayContainer(
                dateTime: currentTime,
                textColor: Colors.grey,
                backgroundColor: Colors.transparent,
                fontWeight: FontWeight.normal),
          );
        },
        defaultBuilder: (context, currentTime, previousTime) {
          return Center(
            child: DayContainer(
                dateTime: currentTime,
                textColor: Colors.black,
                backgroundColor: Colors.transparent,
                fontWeight: FontWeight.normal),
          );
        },
        todayBuilder: (context, currentTime, previousTime) {
          return Center(
            child: DayContainer(
                dateTime: currentTime,
                textColor: Colors.black,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.normal),
          );
        },
        selectedBuilder: (context, currentTime, previousTime) {
          return Center(
            child: DayContainer(
                dateTime: currentTime,
                textColor: Colors.black,
                backgroundColor: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
