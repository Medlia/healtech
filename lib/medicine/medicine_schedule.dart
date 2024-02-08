import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:healtech/service/medicine_notification_service.dart';
import 'package:healtech/medicine/add_medicines.dart';
import 'package:intl/intl.dart';

class MedicineSchedule extends StatefulWidget {
  const MedicineSchedule({super.key});

  @override
  State<MedicineSchedule> createState() => _MedicineScheduleState();
}

class _MedicineScheduleState extends State<MedicineSchedule> {
  late final MedicineNotificationService medicineNotificationService;
  late final CollectionReference medicinesCollection;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    medicineNotificationService = MedicineNotificationService();
    medicineNotificationService.initializeNotification();
    medicinesCollection = FirebaseFirestore.instance.collection('medicines');
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
            "Medicine Schedule",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  right: 8,
                  left: 8,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          DateFormat.yMMMMd().format(
                            _selectedDate,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MedicineDetailInput(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        size: 16,
                      ),
                      label: const Text("Add Medicine"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  deactivatedColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                  monthTextStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  dayTextStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  dateTextStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  onDateChange: (date) {
                    setState(
                      () {
                        _selectedDate = date;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: medicinesCollection.snapshots(),
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
                        if (_selectedDate.isBefore(duration) ||
                            _selectedDate.isAtSameMomentAs(duration)) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  medicineData['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description: ${medicineData['description']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Doctor\'s Name: ${medicineData['doctor\'s name']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Type: ${medicineData['type']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Dosage: ${medicineData['dosage']} mg',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Food Time: ${medicineData['food time']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Duration: ${medicineData['duration']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Quantity: ${medicineData['quantity']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Time: ${medicineData['time']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
