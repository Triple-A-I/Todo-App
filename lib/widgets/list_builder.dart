import 'package:flutter/material.dart';
import 'package:todo_app/business_logic/cubit/app_cubit.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_item.dart';

Widget listBuilder(List<Map> tasks, BuildContext context, String status) {
  AppCubit appCubit = AppCubit.get(context);
  return tasks.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'No Tasks To Show',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 24,
                ),
              ),
              const Icon(
                Icons.filter_list_sharp,
                color: Colors.black26,
                size: 54,
              )
            ],
          ),
        )
      : ListView.separated(
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key('${tasks[index]['id']}'),
              child:
                  buildTaskItem(Task.fromJson(tasks[index]), context, status),
              onDismissed: (direction) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text(
                      'Sure you want to delete the task?',
                      style: TextStyle(color: Colors.black26, fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          appCubit.deleteData(id: tasks[index]['id']);
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          appCubit
                              .getDataFromDataFromDatabase(appCubit.database);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey[400]),
          itemCount: tasks.length,
        );
}
