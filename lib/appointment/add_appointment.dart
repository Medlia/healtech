import 'package:flutter/material.dart';
import 'package:healtech/widgets/detail_input.dart';

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
  late final TextEditingController _doctorName;

  @override
  void initState() {
    _doctorName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _doctorName.dispose();
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              DetailField(
                controller: _doctorName,
                title: 'Doctor\'s name',
                hint: "Enter doctor's name",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
