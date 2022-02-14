part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

// ignore: must_be_immutable
class AppInsertIntoDatabaseState extends AppStates {
  int id;
  AppInsertIntoDatabaseState(this.id);
}

class AppChangeBottomSheetState extends AppStates {}

// ignore: must_be_immutable
class AppArchiveTaskState extends AppStates {
  int id;
  AppArchiveTaskState(this.id);
}

// ignore: must_be_immutable
class AppADoneTaskState extends AppStates {
  int id;
  AppADoneTaskState(this.id);
}

// ignore: must_be_immutable
class AppADeleteTaskState extends AppStates {
  int id;
  AppADeleteTaskState(this.id);
}
