import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/Calender.dart';

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
  var _isEditMode = false;

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
        leading: _isEditMode
            ? IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  print('Add Training');
                },
              )
            : null,
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditMode == true) {
                  print('Edit Mode Disable');
                  _isEditMode = false;
                } else {
                  print('Edit Mode Enable');
                  _isEditMode = true;
                }
              });
            },
          ),
        ],
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
        return Column(
          children: [
            Calendar(),
            Expanded(
              child: ListView.builder(
                // 在Column裡面使用ListView這種具有無限延展性的Widget，需要用Expanded包住
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        children: [
                          Text(
                            "Incline Bench Press",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "2K",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
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
