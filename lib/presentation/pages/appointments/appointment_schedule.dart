import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtech/core/colors.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/presentation/pages/appointments/add_appointment.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:healtech/presentation/pages/appointments/widgets/appointment_display_card.dart';
import 'package:table_calendar/table_calendar.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  late final CollectionReference appointmentCollection;
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    appointmentCollection =
        FirebaseFirestore.instance.collection('appointment');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointments",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: IconButton.filled(
        iconSize: Sizes.largerIcon,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAppointment(
                dateTime: today,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.add_rounded,
          size: Sizes.largeIcon,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: Column(
            children: [
              TableCalendar(
                focusedDay: today,
                firstDay: DateTime.utc(2013),
                lastDay: DateTime.utc(2130),
                rowHeight: Sizes.rowHeight,
                daysOfWeekHeight: Sizes.large,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(day, today);
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left_rounded,
                    size: Sizes.largeIcon,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right_rounded,
                    size: Sizes.largeIcon,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: Sizes.largerFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: Sizes.largeFont,
                    fontWeight: FontWeight.w500,
                  ),
                  weekendStyle: TextStyle(
                    color: CustomColors.darkGrey,
                    fontSize: Sizes.largeFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                    fontSize: Sizes.mediumFont,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    today = selectedDay;
                    focusedDay = today;
                  });
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: appointmentCollection
                      .doc(AuthService.firebase().currentUser!.uid)
                      .collection('entries')
                      .snapshots(),
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
                        child: Text('No appointment added yet.'),
                      );
                    }
                    var allAppointments = snapshot.data!.docs
                        .map((appointment) =>
                            appointment.data() as Map<String, dynamic>)
                        .toList();
                    return ListView.builder(
                      itemCount: allAppointments.length,
                      itemBuilder: (context, index) {
                        var appointmentData = allAppointments[index];
                        var date = appointmentData['date'].split('/');
                        var finalDate = DateTime(
                          int.parse(date[2]),
                          int.parse(date[0]),
                          int.parse(date[1]),
                        );
                        var docID = snapshot.data!.docs[index].id;
                        if (today.year == finalDate.year &&
                            today.month == finalDate.month &&
                            today.day == finalDate.day) {
                          return Dismissible(
                            key: Key(docID),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                allAppointments.removeAt(index);
                              });
                              appointmentCollection.doc(docID).delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface,
                                  content: Text(
                                    "Appointment deleted",
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
                                        allAppointments.insert(
                                          index,
                                          appointmentData,
                                        );
                                      });
                                      appointmentCollection
                                          .add(appointmentData);
                                    },
                                  ),
                                ),
                              );
                            },
                            child: AppointmentDisplayCard(appointmentData: appointmentData),
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
