import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/service/appointment_service.dart';
import 'package:healtech/widgets/detail_input.dart';
import 'package:intl/intl.dart';

class AddAppointment extends StatefulWidget {
  final DateTime dateTime;
  const AddAppointment({
    super.key,
    required this.dateTime,
  });

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  var time = DateFormat("hh:mm a").format(DateTime.now().toLocal());
  var selectedDate = DateFormat.yMd().format(DateTime.now());
  late final TextEditingController _doctorName;
  late final TextEditingController _date;
  late final TextEditingController _time;
  late final TextEditingController _description;
  File? avatar;

  Future<void> handleImageSelection() async {
    File? selectedImage = await AppointmentService.pickImage();
    if (selectedImage != null) {
      setState(() {
        avatar = selectedImage;
      });
      await AppointmentService.uploadImage(avatar);
    }
  }

  @override
  void initState() {
    _doctorName = TextEditingController();
    _date = TextEditingController();
    _time = TextEditingController();
    _description = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    _date.dispose();
    _time.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Add Appointment",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
          child: Column(
            children: [
              DetailField(
                controller: _doctorName,
                title: 'Doctor\'s name',
                hint: "Enter doctor's name",
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DetailField(
                      controller: _date,
                      title: 'Appointment date',
                      hint: selectedDate.toString(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          getDateFromUser();
                        },
                        icon: const Icon(Icons.calendar_today_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DetailField(
                      controller: _time,
                      title: 'Appointment time',
                      hint: time.toString(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          getTimeFromUser();
                        },
                        icon: const Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DetailField(
                controller: _description,
                title: 'Description',
                hint: "Enter description",
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Upload reports",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 80),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Upload prescription",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notes_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 45,
                width: 200,
                child: FilledButton(
                  onPressed: () async {
                    saveAppointmentDetails();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getDateFromUser() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2013),
      lastDate: DateTime(2130),
    );

    if (date != null) {
      setState(() {
        selectedDate = DateFormat.yMd().format(date);
      });
    }
  }

  Future<void> getTimeFromUser() async {
    var pickedTime = await getTimePicker();
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      now.day,
      now.month,
      now.year,
      pickedTime!.hour,
      pickedTime.minute,
    );
    var formattedTime = DateFormat("hh:mm a").format(selectedDateTime);
    setState(() {
      time = formattedTime;
    });
  }

  Future<TimeOfDay?> getTimePicker() async {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );
  }

  Future<void> saveAppointmentDetails() async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('entries')
        .add(
      {
        'doctor\'s name': _doctorName.text,
        'description': _description.text,
        'time': time,
        'date': selectedDate,
      },
    );
  }
}
