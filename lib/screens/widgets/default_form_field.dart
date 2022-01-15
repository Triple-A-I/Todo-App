import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  String label = '',
  required FormFieldValidator validate,
  required GestureTapCallback onTap,
  IconData? icon,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validate,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorStyle: const TextStyle(color: Colors.red),
          hintText: label,
        ));
