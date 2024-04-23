import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/service/auth/auth_service.dart';

Future<void> showLogOutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
            "Are you sure you want to log out? Logging out will require you to sign in again."),
        icon: const Center(
          child: Icon(Icons.info_rounded),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              AuthService.firebase().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                signInRoute,
                (route) => false,
              );
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}
