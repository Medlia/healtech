import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:healtech/core/routes.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/service/medicine_service.dart';
import 'package:healtech/presentation/pages/medicine/widgets/medicine_display_card.dart';
import 'package:intl/intl.dart';

class MedicineSchedule extends StatefulWidget {
  const MedicineSchedule({super.key});

  @override
  State<MedicineSchedule> createState() => _MedicineScheduleState();
}

class _MedicineScheduleState extends State<MedicineSchedule> {
  late final CollectionReference medicinesCollection;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    medicinesCollection = FirebaseFirestore.instance.collection('medicines');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicine Schedule",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  right: Sizes.small,
                  left: Sizes.small,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Sizes.tileSpace),
                        Text(
                          DateFormat.yMMMMd().format(
                            _selectedDate,
                          ),
                          style: const TextStyle(
                            fontSize: Sizes.largeFont,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          "Today",
                          style: TextStyle(
                            fontSize: Sizes.large,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(addMedicineRoute);
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        size: Sizes.mediumFont,
                      ),
                      label: const Text("Add Medicine"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Sizes.sectionSpace),
              Container(
                padding: const EdgeInsets.only(
                  left: Sizes.small,
                  right: Sizes.small,
                ),
                child: DatePicker(
                  DateTime.now(),
                  height: Sizes.calendarHeight,
                  width: Sizes.calendarWidth,
                  initialSelectedDate: DateTime.now(),
                  selectionColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  deactivatedColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                  monthTextStyle: const TextStyle(
                    fontSize: Sizes.mediumFont,
                  ),
                  dayTextStyle: const TextStyle(
                    fontSize: Sizes.mediumFont,
                  ),
                  dateTextStyle: const TextStyle(
                    fontSize: Sizes.mediumFont,
                  ),
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
              const SizedBox(height: Sizes.tileSpace),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: MedicineService.medicineSnapshots,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No medicines added yet.'),
                      );
                    }

                    var allMedicines = snapshot.data!.docs
                        .map((medicine) =>
                            medicine.data() as Map<String, dynamic>)
                        .toList();
                    return ListView.builder(
                      itemCount: allMedicines.length,
                      itemBuilder: (context, index) {
                        var medicineData = allMedicines[index];
                        var durationParts = medicineData['duration'].split('/');
                        var duration = DateTime(
                          int.parse(durationParts[2]),
                          int.parse(durationParts[0]),
                          int.parse(durationParts[1]),
                        );
                        var docID = snapshot.data!.docs[index].id;

                        if (_selectedDate.isBefore(duration) ||
                            _selectedDate.isAtSameMomentAs(duration)) {
                          return Dismissible(
                            key: Key(docID),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                allMedicines.removeAt(index);
                              });
                              medicinesCollection.doc(docID).delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface,
                                  content: Text(
                                    "Medicine deleted",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface,
                                      fontSize: Sizes.mediumFont,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  action: SnackBarAction(
                                    label: "Undo",
                                    onPressed: () {
                                      setState(() {
                                        allMedicines.insert(
                                          index,
                                          medicineData,
                                        );
                                      });
                                      medicinesCollection.add(medicineData);
                                    },
                                  ),
                                ),
                              );
                            },
                            child:
                                MedicineDisplayCard(medicineData: medicineData),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
