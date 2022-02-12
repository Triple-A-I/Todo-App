import 'package:flutter/material.dart';

SnackBar showSnackBar(BuildContext context, String message) {
  return SnackBar(
      content: Text(message),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ));
}
