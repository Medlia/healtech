import 'package:flutter/material.dart';
import 'package:healtech/widgets/medicine_class.dart';
import 'package:intl/intl.dart';

class MedicineDetailInput extends StatefulWidget {
  const MedicineDetailInput({super.key});

  @override
  State<MedicineDetailInput> createState() => _MedicineDetailInputState();
}

class _MedicineDetailInputState extends State<MedicineDetailInput> {
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
    DateTime time = DateTime.now();
    final selectedTime = DateFormat.Hm().format(time.toLocal());
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailField(
                  controller: _name,
                  title: 'Medicine Name',
                  hint: "Enter the name",
                ),
                DetailField(
                  controller: _description,
                  title: 'Description',
                  hint: "Enter the description",
                ),
                DetailField(
                  controller: _doctorName,
                  title: 'Doctor Name',
                  hint: "Enter the doctor's name",
                ),
                DetailField(
                  controller: _type,
                  title: 'Type',
                  hint: "Enter the type",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DetailField(
                        controller: _dosage,
                        title: 'Dosage',
                        hint: "Enter the dosage",
                      ),
                    ),
                    Expanded(
                      child: DetailField(
                        controller: _quantity,
                        title: 'Quantity',
                        hint: "Enter the quantity",
                      ),
                    ),
                  ],
                ),
                DetailField(
                  controller: _foodTime,
                  title: 'Food Time',
                  hint: "Enter the food time",
                ),
                DetailField(
                  controller: _time,
                  title: 'Time',
                  hint: selectedTime.toString(),
                ),
                DetailField(
                  controller: _duration,
                  title: 'Duration',
                  hint: "Enter the duration",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
