import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/business_logic/cubit/app_cubit.dart';
import 'package:recipes/models/task.dart';
import 'package:recipes/widgets/task_item.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              buildTaskItem(Task.fromJson(AppCubit.get(context).tasks[index])),
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey[400]),
          itemCount: AppCubit.get(context).tasks.length,
        );
      },
    );
  }
}
