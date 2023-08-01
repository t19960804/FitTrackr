import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/Calender.dart';

void main() {
  // const > 用來宣告編譯時就已經確定的值, 並且未來不再改變, 因此它只會被創建一次，未來需要時可以直接使用, 省下未來重新創建所需要的資源
  // const不管是用來宣告屬性還是Widget本身, 都要確保"編譯時就已確定的值，而且這些值在未來不會改變"這項原則
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
      home: CalendarPage(navTitle: 'FitTrackr'),
    );
  }
}

class CalendarPage extends StatefulWidget {
  final String navTitle;
  CalendarPage({required this.navTitle});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var _bottomNavigationIndex = 0;
  var _isEditMode = false;
  var _trainings = ["Incline bench press", "Decline bench press"];
  var _selectStatus = [];

  _CalendarPageState() {
    _selectStatus = List.generate(_trainings.length, (index) => false);
  }

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
                onPressed: () {},
              )
            : null,
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditMode == true) {
                  _isEditMode = false;
                } else {
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
                  final training = _trainings[index];
                  final isSelected = _selectStatus[index];

                  return TextButton(
                    onPressed: () {
                      setState(() {
                        _selectStatus.fillRange(0, _selectStatus.length, false);
                        _selectStatus[index] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 80,
                      decoration: BoxDecoration(
                        border: isSelected
                            ? null
                            : Border.all(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          children: [
                            Text(
                              training,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 24,
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "2K",
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 24,
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _trainings.length,
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
