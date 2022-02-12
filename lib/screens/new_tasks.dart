import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        return ListView.separated(
          itemBuilder: (context, index) => Slidable(
            // Specify a key if the Slidable is dismissible.
            key: ObjectKey(index),

            // The start action pane is the one at the left or the top side.
            endActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const BehindMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(
                onDismissed: () {
                  print('Albraa Done');
                },
              ),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (BuildContext context) {
                    print('Albraa Done');
                  },
                  backgroundColor: const Color(0xFF00FF9a),
                  foregroundColor: Colors.white,
                  icon: Icons.done,
                  label: 'Done',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 2,
                  onPressed: (BuildContext context) {},
                  backgroundColor: Color(0xFFFF0000),
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
              ],
            ),

            child: buildTaskItem(
                Task.fromJson(AppCubit.get(context).tasks[index])),
          ),
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey[400]),
          itemCount: AppCubit.get(context).tasks.length,
        );
      },
    );
  }
}
