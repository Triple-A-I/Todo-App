import 'package:flutter/material.dart';
import 'package:todo_app/business_logic/cubit/app_cubit.dart';
import 'package:todo_app/models/task.dart';

Widget buildTaskItem(Task task, BuildContext context, String status) {
  AppCubit appCubit = AppCubit.get(context);

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(task.time),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                // softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                task.date,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        if (status != 'archived')
          IconButton(
            onPressed: () {
              appCubit.updateData(status: 'archived', id: task.id);
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.black45,
            ),
          ),
        if (status != 'done')
          IconButton(
            onPressed: () {
              appCubit.updateData(status: 'done', id: task.id);
            },
            icon: const Icon(
              Icons.task_alt_sharp,
              color: Colors.green,
            ),
          )
      ],
    ),
  );
}
