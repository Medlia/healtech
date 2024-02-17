import 'package:flutter/material.dart';
import 'package:healtech/appointment/add_appointment.dart';
import 'package:table_calendar/table_calendar.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime today = DateTime.now();

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
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
                  headerPadding: EdgeInsets.all(8),
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
            ],
          ),
        ),
      ),
    );
  }
}
