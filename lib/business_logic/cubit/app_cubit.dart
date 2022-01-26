import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/screens/archived_tasks_screen.dart';
import 'package:recipes/screens/done_tasks_screen.dart';
import 'package:recipes/screens/new_tasks.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  int currentIndex = 0;
  final List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  final List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  static AppCubit get(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);

  void changeIndex(int index) {
    currentIndex = index;

    emit(AppChangeBottomNavBarState());
  }
}
