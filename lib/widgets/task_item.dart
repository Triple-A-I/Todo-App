import 'package:flutter/material.dart';
import 'package:recipes/models/task.dart';

Widget buildTaskItem(Task task) {
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
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              task.date,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}
