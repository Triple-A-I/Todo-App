import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/cubit/app_cubit.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_item.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return ListView.separated(
          itemBuilder: (context, index) {
            if (tasks.isEmpty) {
              return const Center(
                child: Text(
                  'No Tasks To Show',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return buildTaskItem(Task.fromJson(tasks[index]), context);
            }
          },
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey[400]),
          itemCount: tasks.length,
        );
      },
    );
  }
}
