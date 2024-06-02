import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
