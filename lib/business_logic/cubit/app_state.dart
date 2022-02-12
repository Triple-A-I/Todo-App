part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppInsertIntoDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}
