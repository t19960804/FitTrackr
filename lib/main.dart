import 'package:fit_trackr/Models/training_option.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/CalenderTab/calender.dart';
import 'package:fit_trackr/Widgets/CalenderTab/today_training_options_list.dart';
import 'package:fit_trackr/Widgets/trainings_grid.dart';
import 'Helpers/database_helper.dart';

enum MainTabType {
  calender,
  training,
}

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
      home: const MainTabPage(navTitle: 'FitTrackr'),
    );
  }
}

class MainTabPage extends StatefulWidget {
  final String navTitle;
  const MainTabPage({super.key, required this.navTitle});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  DateTime _selectedDay = DateTime.now();
  var _bottomNavigationIndex = 0;
  var _isEditMode = false;
  List<TrainingOption> _trainingOptions = [];

  _MainTabPageState() {
    updateTrainingOptions(dateTime: _selectedDay);
  }

  void updateTrainingOptions({required DateTime dateTime}) async {
    final options = await DatabaseHelper.getSharedInstance().readTrainingOptions(
        where:
            "dateTime = ${TrainingOption.getFormattedDateTimeString(dateTime)}");
    setState(() {
      _trainingOptions = options;
    });
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
        leading: (_isEditMode && _bottomNavigationIndex == 0)
            ? IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                      body: TrainingsGrid(
                        type: MainTabType.calender,
                        optionWasSelected: (option) async {
                          option.dateTime =
                              TrainingOption.getFormattedDateTimeString(
                                  _selectedDay);
                          DatabaseHelper.getSharedInstance()
                              .createTrainingOption(option);
                          updateTrainingOptions(dateTime: _selectedDay);
                        },
                      ),
                    );
                  }));
                },
              )
            : null,
        actions: _bottomNavigationIndex == 0
            ? [
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
              ]
            : [],
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
      body: _tabContent(),
    );
  }

  Widget _tabContent() {
    switch (_bottomNavigationIndex) {
      case 0:
        return Center(
          child: Column(
            children: [
              Calendar(
                onDaySelected: (dateTime) {
                  _selectedDay = dateTime;
                  updateTrainingOptions(dateTime: _selectedDay);
                },
              ),
              TodayTrainingOptionsList(
                  trainingOptions: _trainingOptions, isEditMode: _isEditMode),
            ],
          ),
        );
      case 1:
        return Center(
          child: TrainingsGrid(
            type: MainTabType.training,
            optionWasSelected: (option) async {},
          ),
        );
      default:
        return Container();
    }
  }
}
