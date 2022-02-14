import 'package:flutter/material.dart';

SnackBar showSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: (Colors.blueAccent),
    action: SnackBarAction(
      label: '',
      onPressed: () {},
    ),
  );
}
