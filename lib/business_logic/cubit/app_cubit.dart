import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:sqflite/sqflite.dart';
import 'package:todo_app/screens/archived_tasks_screen.dart';
import 'package:todo_app/screens/done_tasks_screen.dart';
import 'package:todo_app/screens/new_tasks.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  int currentIndex = 1;
  final List<String> titles = ['Done Tasks', 'New Tasks', 'Archived Tasks'];

  final List<Widget> screens = [
    const DoneTasksScreen(),
    const NewTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;

    emit(AppChangeBottomNavBarState());
  }

  void createDatabase(BuildContext context) {
    openDatabase(
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
        getDataFromDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShowing = false;

  void changeBottomSheetState({required IconData icon, required bool isShow}) {
    isBottomSheetShowing = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  updateData({required String status, required int id}) async {
    await database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      if (status == 'done') {
        emit(AppADoneTaskState(value));
      } else if (status == 'archived') {
        emit(AppArchiveTaskState(value));
      }
      getDataFromDataFromDatabase(database);
    });
  }

  Future<void> insertIntoDatabase(
      String title, String time, String date) async {
    await database.transaction((txn) => txn
            .rawInsert(
                "INSERT INTO tasks(title, date, time, status) VALUES('$title','$date','$time','new')")
            .then((value) {
          print('$value inserted to Database Successfully');
          emit(AppInsertIntoDatabaseState(value));
          getDataFromDataFromDatabase(database);
        }).catchError(
          (error) {},
        ));
  }

  getDataFromDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      newTasks = value;
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
        emit(AppGetDatabaseState());
      });
    });
  }
}
