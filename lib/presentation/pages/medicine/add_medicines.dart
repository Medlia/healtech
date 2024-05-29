import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtech/core/colors.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:healtech/service/medicine_service.dart';
import 'package:healtech/core/widgets/detail_input.dart';
import 'package:intl/intl.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
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
            top: Sizes.small,
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
            padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
            child: Column(
              children: [
                const Text(
                  "All the fields are mandatory",
                  style: TextStyle(
                    color: CustomColors.errorColor,
                    fontSize: Sizes.smallFont,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: Sizes.tileSpace),
                DetailField(
                  controller: _name,
                  type: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Medicine Name',
                  hint: "Enter medicine's name",
                ),
                const SizedBox(height: Sizes.sectionSpace),
                DetailField(
                  controller: _description,
                  type: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Description',
                  hint: "Enter the description",
                ),
                const SizedBox(height: Sizes.sectionSpace),
                DetailField(
                  controller: _doctorName,
                  type: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Doctor\'s Name',
                  hint: "Enter the doctor's name",
                ),
                const SizedBox(height: Sizes.sectionSpace),
                DetailField(
                  controller: _type,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Type',
                  hint: "Enter the type of medicine",
                ),
                const SizedBox(height: Sizes.sectionSpace),
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
                    const SizedBox(width: Sizes.tileSpace),
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
                const SizedBox(height: Sizes.sectionSpace),
                DetailField(
                  controller: _foodTime,
                  type: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Food Time',
                  hint: "Before/After",
                ),
                const SizedBox(height: Sizes.sectionSpace),
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
                            MedicineService.getTimeFromUser(context, this);
                          },
                          icon: const Icon(Icons.access_time_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.tileSpace),
                    Expanded(
                      child: DetailField(
                        controller: _duration,
                        title: 'Duration',
                        hint: selectedDate.toString(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            MedicineService.getDateFromUser(context, this);
                          },
                          icon: const Icon(Icons.calendar_today_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.largerSpace),
                SizedBox(
                  height: Sizes.buttonHeight,
                  width: Sizes.buttonWidth,
                  child: FilledButton(
                    onPressed: () async {
                      saveMedicineDetails();
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        fontSize: Sizes.mediumFont,
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

  Future<void> saveMedicineDetails() async {
    await FirebaseFirestore.instance
        .collection('medicines')
        .doc(AuthService.firebase().currentUser?.uid)
        .collection('entries')
        .add(
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
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        content: Text(
          "Medicine saved!",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
            fontSize: Sizes.mediumFont,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
    Navigator.pop(context);
  }
}
