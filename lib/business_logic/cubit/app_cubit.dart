import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/screens/archived_tasks_screen.dart';
import 'package:recipes/screens/done_tasks_screen.dart';
import 'package:recipes/screens/new_tasks.dart';
import 'package:sqflite/sqflite.dart';

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
        getDataFromDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
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
  List<Map> tasks = [];

  Future<void> insertIntoDatabase(
      String title, String time, String date) async {
    await database.transaction((txn) => txn
            .rawInsert(
                "INSERT INTO tasks(title, date, time, status) VALUES('$title','$date','$time','new')")
            .then((value) {
          print('$value inserted to Database Successfully');
          emit(AppInsertIntoDatabaseState());
          getDataFromDataFromDatabase(database).then((value) {
            tasks = value;
            print(tasks);
            emit(AppGetDatabaseState());
          });
        }).catchError(
          (error) {},
        ));
  }

  Future<List<Map>> getDataFromDataFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery("SELECT * FROM tasks");
  }
}
