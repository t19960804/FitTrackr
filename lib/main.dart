import 'package:flutter/material.dart';

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
            primary: Color(0xFFFF9800), secondary: Color(0xFFF57C00)),
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
        return const Center(
          child: Text('Calendar'),
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
