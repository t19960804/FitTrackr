import 'package:fit_trackr/Models/TrainingPart.dart';
import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/Calender.dart';
import 'package:fit_trackr/Widgets/TodayTrainingOptionsList.dart';
import 'package:fit_trackr/Widgets/TrainingsGrid.dart';
import 'SQLiteDB.dart';

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
      home: MainTabPage(navTitle: 'FitTrackr'),
    );
  }
}

class MainTabPage extends StatefulWidget {
  final String navTitle;
  MainTabPage({required this.navTitle});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  var _bottomNavigationIndex = 0;
  var _isEditMode = false;
  List<TrainingOption> _trainingOptions = [];

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
                        willPop: true,
                        optionWasSelected: (option) {
                          setState(() {
                            _trainingOptions.add(option);
                          });
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
      body: _TabContent(),
    );
  }

  Widget _TabContent() {
    switch (_bottomNavigationIndex) {
      case 0:
        return Center(
          child: Column(
            children: [
              Calendar(),
              TodayTrainingOptionsList(_trainingOptions),
            ],
          ),
        );
      case 1:
        return Center(
          child: TrainingsGrid(
            willPop: false,
            optionWasSelected: (option) async {
              final option = TrainingOption(
                  name: "Decline Bench Press",
                  volume: 100,
                  dateTime: DateTime.now().toString());
              DatabaseHelper.getSharedInstance().createTrainingOption(option);
              final options = await DatabaseHelper.getSharedInstance()
                  .readTrainingOptions();
              options.forEach((option) {
                print(
                    'id: ${option.id}, name: ${option.name}, volume: ${option.volume}, dateTime: ${option.dateTime}');
              });
            },
          ),
        );
      default:
        return Container();
    }
  }
}
