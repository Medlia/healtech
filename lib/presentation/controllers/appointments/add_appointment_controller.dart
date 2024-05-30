import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtech/data/models/appointment_model.dart';
import 'package:healtech/domain/usecases/save_appointment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddAppointmentController extends GetxController {
  final SaveAppointment saveAppointment;
  AddAppointmentController(this.saveAppointment);

  var doctorName = TextEditingController();
  var description = TextEditingController();
  var date = ''.obs;
  var time = DateFormat("hh:mm a").format(DateTime.now().toLocal()).obs;
  var reports = Rxn<File>();
  var prescription = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    var now = DateTime.now();
    date.value = DateFormat.yMd().format(now);
  }

  Future<void> getTimeFromUser(BuildContext context) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.day,
        now.month,
        now.year,
        pickedTime.hour,
        pickedTime.minute,
      );
      time.value = DateFormat("hh:mm a").format(selectedDateTime);
    }
  }

  Future<void> pickFile(Rx<File?> file) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file.value = File(pickedFile.path);
    }
  }

  Future<void> saveAppointmentDetails() async {
    String? reportsURL;
    String? prescriptionURL;

    if (reports.value != null) {
      reportsURL = await saveAppointment.uploadFile(
        reports.value!,
        'reports',
      );
    }
    if (prescription.value != null) {
      prescriptionURL = await saveAppointment.uploadFile(
        prescription.value!,
        'prescriptions',
      );
    }

    final appointment = AppointmentModel(
      doctorName: doctorName.text,
      description: description.text,
      date: date.value,
      time: time.value,
      reportsURL: reportsURL,
      prescriptionURL: prescriptionURL,
    );

    await saveAppointment(appointment);
  }
}
