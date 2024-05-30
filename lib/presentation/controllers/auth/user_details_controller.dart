import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtech/data/models/user_details_model.dart';
import 'package:healtech/domain/usecases/save_user_details.dart';

class UserDetailsController extends GetxController {
  final SaveUserDetails saveUserDetails;

  UserDetailsController(this.saveUserDetails);

  var gender = TextEditingController();
  var age = TextEditingController();
  var weight = TextEditingController();

  @override
  void onClose() {
    gender.dispose();
    age.dispose();
    weight.dispose();
    super.onClose();
  }

  Future<void> saveDetails() async {
    final details = UserDetailsModel(
      gender: gender.text,
      age: age.text,
      weight: weight.text,
    );
    await saveUserDetails(details);
  }
}
