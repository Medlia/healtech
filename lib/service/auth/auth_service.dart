import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/widgets/error_dialog.dart';

class AuthService {
  static Future<void> signup(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user?.uid)
          .set(
        {
          'email': email,
        },
      );
      if (!context.mounted) return;
      emailVerification(context);
      Navigator.of(context).pushNamed(verifyEmailRoute);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'invalid-email') {
        showErrorDialog(
          context,
          "Invalid email",
          "Enter a valid email address",
        );
      } else if (e.code == 'weak-password') {
        showErrorDialog(
          context,
          "Weak password",
          "Enter a password with more than 6 characters",
        );
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(
          context,
          "Email already in use",
          "Proceed to sign in using this email",
        );
      } else {
        showErrorDialog(
          context,
          "An exception occurred",
          e.toString(),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      showErrorDialog(
        context,
        "An exception occurred",
        e.toString(),
      );
    }
  }

  static Future<void> signin(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!context.mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        navBarRoute,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        showErrorDialog(
          context,
          "User not found",
          "Sign up to create your account",
        );
      } else if (e.code == 'wrong-password') {
        showErrorDialog(
          context,
          "Wrong password",
          "Enter the right password to sign in",
        );
      } else {
        showErrorDialog(
          context,
          "An exception occurred",
          "Try signing in again",
        );
      }
    } catch (e) {
      showErrorDialog(
        context,
        "An exception occurred",
        "Try signing in again",
      );
    }
  }

  static Future<void> emailVerification(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
      if (!context.mounted) return;
      showErrorDialog(
        context,
        "Something went wrong",
        e.toString(),
      );
    }
  }

  static Future<void> forgetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        showErrorDialog(
          context,
          "User not found",
          "Sign up to create your account",
        );
      } else if (e.code == 'invalid-email') {
        showErrorDialog(
          context,
          "Invalid email",
          "Enter a valid email address",
        );
      } else {
        showErrorDialog(
          context,
          "Something went wrong",
          e.toString(),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      showErrorDialog(
        context,
        "Something went wrong",
        e.toString(),
      );
    }
  }

  static Future<void> saveUserDetails(
      BuildContext context, String gender, String age, String weight) async {
    await FirebaseFirestore.instance
        .collection('details')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'gender': gender,
        'age': age,
        'weight': weight,
      },
    );
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      navBarRoute,
      (route) => false,
    );
  }

  static Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      signInRoute,
      (route) => false,
    );
  }
}
