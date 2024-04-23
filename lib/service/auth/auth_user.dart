import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

// The Firebase user should not be exposed in the UI of the application
// A separate class must be created to define the user
// A factory initializer is used to create our user from the Firebase user
// This way we are not directly using the Firebase user

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String uid;
  const AuthUser(
    this.isEmailVerified,
    this.uid,
  );

  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.emailVerified,
        user.uid,
      );
}
