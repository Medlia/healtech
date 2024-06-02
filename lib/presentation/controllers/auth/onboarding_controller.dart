import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final PageController page = PageController();

  @override
  void onClose() {
    page.dispose();
    super.onClose();
  }
}