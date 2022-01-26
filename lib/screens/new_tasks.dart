import 'package:flutter/material.dart';
import 'package:recipes/constants.dart';
import 'package:recipes/models/task.dart';
import 'package:recipes/widgets/task_item.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          buildTaskItem(Task.fromJson(tasks[index])),
      separatorBuilder: (context, index) => Divider(color: Colors.grey[400]),
      itemCount: tasks.length,
    );
  }
}
