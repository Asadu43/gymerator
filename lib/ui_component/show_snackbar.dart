import 'package:flutter/material.dart'
    show BuildContext, Colors, ScaffoldMessenger, SnackBar, Text, TextStyle;

enum SnackBarType { success, failed }

void showSnackBar(BuildContext context, String message,
    {SnackBarType type = SnackBarType.failed}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    ),
    backgroundColor:
        type == SnackBarType.failed ? Colors.red : Colors.green.shade700,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
