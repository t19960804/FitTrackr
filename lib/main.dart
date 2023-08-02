import 'package:flutter/material.dart';
import 'package:fit_trackr/Widgets/Calender.dart';
import 'package:fit_trackr/Widgets/TodayTrainingList.dart';
import 'package:fit_trackr/Models/Training.dart';

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
  var _training = ["Incline bench press", "Decline bench press"];

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
              TodayTrainingList(_training),
            ],
          ),
        );
      case 1:
        return Center(
          child: TrainingsGrid(),
        );
      default:
        return Container();
    }
  }
}

class TrainingsGrid extends StatefulWidget {
  var trainings = [
    Training(
      "Chest",
      [
        "Incline Bench Press",
        "Decline Bench Press",
        "Chest Fly",
        "Flat Bench Press",
      ],
    ),
    Training(
      "Leg",
      [
        "Hack Squat",
        "Leg Curl",
        "Adductor",
        "Leg Extension",
        "RDL",
      ],
    ),
    Training(
      "Back",
      [
        "Low Back",
        "Wide Lat Pull Down",
        "Narrow Lat Pull Down",
        "Leg Extension",
        "Straight arm row",
      ],
    ),
  ];
  var selectStatus = [];

  TrainingsGrid() {
    _resetSelectStatus();
  }

  void _resetSelectStatus() {
    selectStatus = List.generate(
      trainings.length,
      (index) => List.generate(trainings[index].options.length, (i) => false),
    );
  }

  @override
  State<TrainingsGrid> createState() => _TrainingsGridState();
}

class _TrainingsGridState extends State<TrainingsGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _HeaderAndCells(widget.trainings),
      ),
    );
  }

  List<Widget> _HeaderAndCells(List<Training> trainings) {
    List<Widget> widgets = [];
    for (int i = 0; i < trainings.length; i++) {
      final part = trainings[i].part;
      final options = trainings[i].options;

      final header = SliverAppBar(
        expandedHeight: 100, // 設置AppBar展開的高度
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            part,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey),
          ),
        ),
      );
      final cells = SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int j) {
            final isSelected = widget.selectStatus[i][j];
            return TextButton(
              onPressed: () {
                setState(() {
                  widget._resetSelectStatus();
                  widget.selectStatus[i][j] = true;
                  print(options[j]);
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: isSelected
                      ? null
                      : Border.all(
                          color: Colors.grey,
                          width: 3.0,
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
                child: Text(
                  options[j],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            );
          },
          childCount: options.length,
        ),
      );
      widgets.add(header);
      widgets.add(cells);
    }
    return widgets;
  }
}
