import 'package:flutter/material.dart';

class MedicineDetails {
  final String name;
  final String description;
  final String medicineClass;
  final String doctorName;
  final String type;
  final int dosage;
  final int quantity;
  final String foodTime;
  final TimeOfDay time;
  final int duration;

  MedicineDetails({
    required this.name,
    required this.description,
    required this.medicineClass,
    required this.doctorName,
    required this.type,
    required this.dosage,
    required this.quantity,
    required this.foodTime,
    required this.time,
    required this.duration,
  });
}

class MedicineCard extends StatefulWidget {
  const MedicineCard({super.key});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
