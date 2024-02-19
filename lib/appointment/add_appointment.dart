import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healtech/widgets/detail_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

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
  late DateTime selectedDate;
  late String date;
  var time = DateFormat("hh:mm a").format(DateTime.now().toLocal());
  late final TextEditingController _doctorName;
  late final TextEditingController _date;
  late final TextEditingController _time;
  late final TextEditingController _description;
  File? reports;
  File? prescription;

  @override
  void initState() {
    selectedDate = widget.dateTime;
    var splitDate = selectedDate.toString().split(" ");
    DateTime finalDate = DateTime.parse(splitDate[0]);
    date = DateFormat.yMd().format(finalDate);
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

  Future<File?> pickReportsFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future<File?> pickPrescriptionFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> uploadFile(File file, String folder) async {
    try {
      final fileName = path.basename(file.path);
      final destination = '$folder/$fileName';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(destination);
      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveAppointmentDetails() async {
    String? reportsURL;
    String? prescriptionURL;
    if (reports != null) {
      reportsURL = await uploadFile(reports!, 'reports');
    }
    if (prescription != null) {
      prescriptionURL = await uploadFile(prescription!, 'prescriptions');
    }
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('entries')
        .add(
      {
        'doctor\'s name': _doctorName.text,
        'description': _description.text,
        'time': time,
        'date': date,
        'reports': reportsURL,
        'prescription': prescriptionURL,
      },
    );
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Column(
              children: [
                Text(
                  "All the fields are mandatory",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                DetailField(
                  controller: _doctorName,
                  type: TextInputType.text,
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
                        hint: date,
                        readOnly: true,
                        suffixIcon: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.calendar_today_rounded),
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
                  type: TextInputType.text,
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
                        onPressed: () async {
                          final file = await pickReportsFile();
                          setState(() {
                            reports = file;
                          });
                        },
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
                        onPressed: () async {
                          final file = await pickPrescriptionFile();
                          setState(() {
                            prescription = file;
                          });
                        },
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
      ),
    );
  }
}
