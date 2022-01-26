import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/business_logic/cubit/app_cubit.dart';
import 'package:recipes/widgets/default_form_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  late Database database;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShowing = false;

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(appCubit.titles[appCubit.currentIndex]),
            elevation: .5,
          ),
          body: true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : appCubit.screens[appCubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            child: Icon(fabIcon),
            onPressed: () {
              if (isBottomSheetShowing) {
                if (formKey.currentState!.validate()) {
                  insertIntoDatabase(titleController.text, timeController.text,
                          dateController.text)
                      .then((value) {
                    getDataFromDataFromDatabase(database).then((value) {
                      Navigator.pop(context);
                      // setState(() {
                      //   isBottomSheetShowing = false;
                      //   fabIcon = Icons.edit;
                      //   tasks = value;
                      // });
                    });
                  });

                  // scaffoldKey.currentState!
                  //     .showSnackBar(SnackBar(content: new Text("Added Succfully")));
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => SingleChildScrollView(
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
                                      timeController.text =
                                          value!.format(context);
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
                                      dateController.text =
                                          DateFormat.yMMMEd().format(value!);
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
                      elevation: 15,
                    )
                    .closed
                    .then((value) {
                  // Navigator.pop(context);
                  isBottomSheetShowing = false;
                  titleController.text = '';
                  timeController.text = '';
                  dateController.text = '';
                  // setState(() {
                  //   fabIcon = Icons.edit;
                  // });
                });
                isBottomSheetShowing = true;
                // setState(() {
                //   fabIcon = Icons.add;
                // });
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              appCubit.changeIndex(index);
            },
            currentIndex: appCubit.currentIndex,
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
      },
    );
  }

  void createDatabase(BuildContext context) async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)")
            .then((value) {})
            .catchError((error) {
          showDialog(
              context: context, builder: (context) => Text(error.toString()));
        });
      },
      onOpen: (database) {
        getDataFromDataFromDatabase(database).then((value) {
          // setState(() {
          //   tasks = value;
          // });
        });
      },
    );
  }

  Future insertIntoDatabase(String title, String time, String date) async {
    return await database.transaction((txn) => txn
        .rawInsert(
            "INSERT INTO tasks(title, date, time, status) VALUES('$title','$date','$time','new')")
        .then((value) {})
        .catchError(
          (error) {},
        ));
  }

  Future<List<Map>> getDataFromDataFromDatabase(database) async {
    return await database.rawQuery("SELECT * FROM tasks");
  }
}
