import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicineService {
  static final Stream<QuerySnapshot> medicineSnapshots = FirebaseFirestore
      .instance
      .collection('medicines')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('entries')
      .snapshots();

  static final Stream<QuerySnapshot> orderedMedicineSnapshots =
      FirebaseFirestore.instance
          .collection('medicines')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('entries')
          .orderBy('name', descending: false)
          .snapshots();

  static Future<void> getDateFromUser(BuildContext context, state) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2013),
      lastDate: DateTime(2130),
    );

    if (date != null) {
      state.setState(() {
        state.selectedDate = DateFormat.yMd().format(date);
      });
    }
  }

  static Future<TimeOfDay?> getTimePicker(BuildContext context) async {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );
  }

  static Future<void> getTimeFromUser(BuildContext context, state) async {
    var pickedTime = await getTimePicker(context);
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      now.day,
      now.month,
      now.year,
      pickedTime!.hour,
      pickedTime.minute,
    );
    var formattedTime = DateFormat("hh:mm a").format(selectedDateTime);
    state.setState(() {
      state.time = formattedTime;
    });
  }
}
