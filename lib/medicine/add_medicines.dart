import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/service/medication_service.dart';
import 'package:healtech/widgets/medicine_detail_input.dart';
import 'package:intl/intl.dart';

class MedicineDetailInput extends StatefulWidget {
  const MedicineDetailInput({super.key});

  @override
  State<MedicineDetailInput> createState() => _MedicineDetailInputState();
}

class _MedicineDetailInputState extends State<MedicineDetailInput> {
  DateTime today = DateTime.now();
  var time = DateFormat("hh:mm a").format(DateTime.now().toLocal());
  var selectedDate = DateFormat.yMd().format(DateTime.now());

  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _doctorName;
  late final TextEditingController _type;
  late final TextEditingController _dosage;
  late final TextEditingController _quantity;
  late final TextEditingController _foodTime;
  late final TextEditingController _time;
  late final TextEditingController _duration;

  @override
  void initState() {
    _name = TextEditingController();
    _description = TextEditingController();
    _doctorName = TextEditingController();
    _type = TextEditingController();
    _dosage = TextEditingController();
    _quantity = TextEditingController();
    _foodTime = TextEditingController();
    _time = TextEditingController();
    _duration = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _doctorName.dispose();
    _type.dispose();
    _dosage.dispose();
    _quantity.dispose();
    _foodTime.dispose();
    _time.dispose();
    _duration.dispose();
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
            "Add Medicine",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailField(
                  controller: _name,
                  type: TextInputType.text,
                  title: 'Medicine Name',
                  hint: "Name",
                ),
                const SizedBox(height: 10),
                DetailField(
                  controller: _description,
                  type: TextInputType.text,
                  title: 'Description',
                  hint: "Description",
                ),
                const SizedBox(height: 10),
                DetailField(
                  controller: _doctorName,
                  type: TextInputType.text,
                  title: 'Doctor Name',
                  hint: "Doctor's name",
                ),
                const SizedBox(height: 10),
                DetailField(
                  controller: _type,
                  title: 'Type',
                  hint: "Type",
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DetailField(
                        controller: _dosage,
                        type: TextInputType.number,
                        title: 'Dosage',
                        hint: "Dosage",
                        suffixText: "mg",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DetailField(
                        controller: _quantity,
                        type: TextInputType.number,
                        title: 'Quantity',
                        hint: "Quantity",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DetailField(
                  controller: _foodTime,
                  type: TextInputType.text,
                  title: 'Food Time',
                  hint: "Before/After",
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DetailField(
                        controller: _time,
                        title: 'Time',
                        hint: time.toString(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            getTimeFromUser();
                          },
                          icon: const Icon(Icons.access_time_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DetailField(
                        controller: _duration,
                        title: 'Duration',
                        hint: selectedDate.toString(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            getDateFromUser();
                          },
                          icon: const Icon(Icons.calendar_today_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      saveMedicineDetails();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          content: Text(
                            "Medication added",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
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
      setState(
        () {
          selectedDate = DateFormat.yMd().format(date);
        },
      );
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
    setState(
      () {
        time = formattedTime;
      },
    );
  }

  Future<TimeOfDay?> getTimePicker() async {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );
  }

  Future<void> saveMedicineDetails() async {
    var parts = time.split(' ');
    var completeTime = parts[0].split(':');
    await MedicationService.scheduledNotification(
        int.parse(completeTime[0]),
        int.parse(completeTime[1]),
        "Remember to take ${_quantity.text} of ${_dosage.text} of ${_name.text} at $time");
    await FirebaseFirestore.instance
        .collection('medicines')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'name': _name.text,
        'description': _description.text,
        'doctor\'s name': _doctorName.text,
        'type': _type.text,
        'dosage': _dosage.text,
        'quantity': _quantity.text,
        'food time': _foodTime.text,
        'time': time,
        'duration': selectedDate,
      },
    );
    if (!context.mounted) return;
    Navigator.pop(context);
  }
}
