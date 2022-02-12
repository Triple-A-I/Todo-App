import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipes/business_logic/cubit/app_cubit.dart';
import 'package:recipes/widgets/bottom_navigation_bar.dart';
import 'package:recipes/widgets/default_form_field.dart';

@immutable
// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppInsertIntoDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(appCubit.titles[appCubit.currentIndex]),
            elevation: .5,
          ),
          body: state is! AppGetDatabaseLoadingState
              ? appCubit.screens[appCubit.currentIndex]
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(appCubit.fabIcon),
            onPressed: () {
              if (appCubit.isBottomSheetShowing) {
                if (formKey.currentState!.validate()) {
                  appCubit
                      .insertIntoDatabase(titleController.text,
                          timeController.text, dateController.text)
                      .then((value) {
                    final snackBar = SnackBar(
                        content: const Text('Inserted Successfully!'),
                        backgroundColor: (Colors.black12),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });

                  // .then((value) {
                  //   appCubit
                  //       .getDataFromDataFromDatabase(appCubit.database)
                  //       .then((value) {
                  //   });
                  // });
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return "Tasks title mustn't be Empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {},
                                  icon: Icons.title,
                                  label: 'Task Title',
                                  controller: titleController,
                                  type: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return "Tasks Time mustn't be Empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context);
                                    });
                                  },
                                  icon: Icons.watch_later_outlined,
                                  label: "Task Time",
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return "Tasks Date mustn't be Empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2022-09-04"),
                                      initialDate: DateTime.now(),
                                      context: context,
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMEd().format(value!);
                                    });
                                  },
                                  icon: Icons.calendar_today,
                                  label: "Task Date",
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      elevation: 15,
                    )
                    .closed
                    .then((value) {
                  appCubit.changeBottomSheetState(
                      icon: Icons.edit, isShow: false);
                });
                appCubit.changeBottomSheetState(icon: Icons.add, isShow: true);
              }
            },
          ),
          bottomNavigationBar: bottomNavigationBar(context),
        );
      },
    );
  }
}
