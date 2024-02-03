import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String title,
  String content,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        icon: const Center(
          child: Icon(Icons.info),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
