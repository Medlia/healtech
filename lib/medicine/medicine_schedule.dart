import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:healtech/service/medicine_notification_service.dart';
import 'package:healtech/widgets/medicine_detail_input.dart';
import 'package:intl/intl.dart';

class MedicineSchedule extends StatefulWidget {
  const MedicineSchedule({super.key});

  @override
  State<MedicineSchedule> createState() => _MedicineScheduleState();
}

class _MedicineScheduleState extends State<MedicineSchedule> {
  late final MedicineNotificationService medicineNotificationService;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    medicineNotificationService = MedicineNotificationService();
    medicineNotificationService.initializeNotification();
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
                    _selectedDate = date;
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
