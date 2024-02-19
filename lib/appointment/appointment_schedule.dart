import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/appointment/add_appointment.dart';
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
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Appointments",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButton: IconButton.filled(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color(0xFF5c6bc0),
          ),
        ),
        iconSize: 40,
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
        icon: Icon(
          Icons.add_rounded,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            children: [
              TableCalendar(
                focusedDay: today,
                firstDay: DateTime.utc(2013),
                lastDay: DateTime.utc(2130),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(day, today);
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left_rounded,
                    size: 30,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                daysOfWeekHeight: 24,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  weekendStyle: TextStyle(
                    color: Color(0xFF6A6A6A),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                    fontSize: 16,
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
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: appointmentCollection
                      .doc(FirebaseAuth.instance.currentUser?.uid)
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
                                      fontSize: 16,
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
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 260,
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    appointmentData['doctor\'s name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description: ${appointmentData['description']}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Time: ${appointmentData['time']}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        'Date: ${appointmentData['date']}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                barrierColor: Theme.of(context)
                                                    .colorScheme
                                                    .scrim,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    child: Image.network(
                                                      appointmentData[
                                                          'reports'],
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Image.network(
                                              appointmentData['reports'],
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                barrierColor: Theme.of(context)
                                                    .colorScheme
                                                    .scrim,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    child: Image.network(
                                                      appointmentData[
                                                          'prescription'],
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Image.network(
                                              appointmentData['prescription'],
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
