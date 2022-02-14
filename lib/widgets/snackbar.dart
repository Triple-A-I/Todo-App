import 'package:flutter/material.dart';

SnackBar showSnackBar(BuildContext context, String message) {
  return SnackBar(
    duration: const Duration(milliseconds: 500),
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
