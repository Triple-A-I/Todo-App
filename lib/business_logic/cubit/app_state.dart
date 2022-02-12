part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppInsertIntoDatabaseState extends AppStates {
  int id;
  AppInsertIntoDatabaseState(this.id);
}

class AppChangeBottomSheetState extends AppStates {}

class AppArchiveTaskState extends AppStates {
  int id;
  AppArchiveTaskState(this.id);
}

class AppADoneTaskState extends AppStates {
  int id;
  AppADoneTaskState(this.id);
}

class AppADeleteTaskState extends AppStates {}
