import 'package:flutter/material.dart';
import 'package:recipes/business_logic/cubit/app_cubit.dart';

Widget bottomNavigationBar(BuildContext context) {
  AppCubit appCubit = AppCubit.get(context);

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    onTap: (int index) {
      appCubit.changeIndex(index);
    },
    currentIndex: appCubit.currentIndex,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.task),
        label: 'Done',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.article),
        label: 'Tasks',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.archive),
        label: 'Archived',
      ),
    ],
  );
}
