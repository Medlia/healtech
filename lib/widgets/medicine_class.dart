import 'package:flutter/material.dart';

class MedicineDetails {
  final String name;
  final String description;
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
    required this.doctorName,
    required this.type,
    required this.dosage,
    required this.quantity,
    required this.foodTime,
    required this.time,
    required this.duration,
  });
}

class DetailField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const DetailField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  State<DetailField> createState() => _DetailFieldState();
}

class _DetailFieldState extends State<DetailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
