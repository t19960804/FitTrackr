import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Color(0xFFFF9800), secondary: Color(0xFFFFB74D)),
        useMaterial3: true,
      ),
      home: const CalendarPage(navTitle: 'FitTrackr'),
    );
  }
}

class CalendarPage extends StatefulWidget {
  final String navTitle;
  const CalendarPage({super.key, required this.navTitle});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var _bottomNavigationIndex = 0;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

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
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _bottomNavigationIndex = value;
          });
        },
        currentIndex: _bottomNavigationIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Training',
          ),
        ],
      ),
      body: Center(
        child: _tabContent(),
      ),
    );
  }

  Widget _tabContent() {
    switch (_bottomNavigationIndex) {
      case 0:
        return Center(
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarBuilders: CalendarBuilders(
              outsideBuilder: (context, currentTime, previousTime) {
                var displayString = "${currentTime.day}";
                if (currentTime.day < 10) {
                  displayString = "0${currentTime.day}";
                }
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayString,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              defaultBuilder: (context, currentTime, previousTime) {
                var displayString = "${currentTime.day}";
                if (currentTime.day < 10) {
                  displayString = "0${currentTime.day}";
                }
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayString,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              todayBuilder: (context, currentTime, previousTime) {
                var displayString = "${currentTime.day}";
                if (currentTime.day < 10) {
                  displayString = "0${currentTime.day}";
                }
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayString,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              selectedBuilder: (context, currentTime, previousTime) {
                var displayString = "${currentTime.day}";
                if (currentTime.day < 10) {
                  displayString = "0${currentTime.day}";
                }
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayString,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      case 1:
        return const Center(
          child: Text('Training'),
        );
      default:
        return Container();
    }
  }
}
