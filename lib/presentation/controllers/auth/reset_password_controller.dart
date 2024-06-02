import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController email = TextEditingController();

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
