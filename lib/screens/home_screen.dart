import 'package:flutter/material.dart';
import 'package:recipes/screens/archived_tasks_screen.dart';
import 'package:recipes/screens/done_tasks_screen.dart';
import 'package:recipes/screens/new_tasks.dart';
import 'package:recipes/screens/widgets/default_form_field.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShowing = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  final List<Widget> _screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  final List<String> _titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        elevation: .5,
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(fabIcon),
        onPressed: () {
          if (isBottomSheetShowing) {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);
              isBottomSheetShowing = false;
              setState(() {
                fabIcon = Icons.edit;
              });
              scaffoldKey.currentState!
                  .showSnackBar(SnackBar(content: new Text("Added Succfully")));
            }
          } else {
            scaffoldKey.currentState!.showBottomSheet(
              (context) {
                return SingleChildScrollView(
                  child: Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "Tasks title mustn't be Empty";
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {},
                              icon: Icons.title,
                              label: 'Task Title',
                              controller: titleController,
                              type: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "Tasks Time mustn't be Empty";
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text = value!.format(context);
                                });
                              },
                              icon: Icons.watch_later_outlined,
                              label: "Task Time",
                              controller: timeController,
                              type: TextInputType.datetime,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "Tasks Date mustn't be Empty";
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                showDatePicker(
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2022-02-04"),
                                  initialDate: DateTime.now(),
                                  context: context,
                                ).then((value) {
                                  dateController.text = value.toString();
                                  print(value.toString());
                                });
                              },
                              icon: Icons.calendar_today,
                              label: "Task Date",
                              controller: dateController,
                              type: TextInputType.datetime,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
            isBottomSheetShowing = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)")
            .then((value) {
          print("Database created");
        }).catchError((error) {
          print("Error When Creating table ${error.toString()}");
        });
      },
      onOpen: (database) {
        print("Database opened");
      },
    );
  }

  Future<void> insertIntoDatabase() async {
    database.transaction((txn) => txn
            .rawInsert(
                "INSERT INTO tasks(title, date, time, status) VALUES('First Task','12-1-2021','2121','new')")
            .then((value) {
          print("$value Inserted Successfully!!");
        }).catchError(
          (error) {
            print("Error When Inserting New Record ${error.toString()}");
          },
        ));
  }
}
