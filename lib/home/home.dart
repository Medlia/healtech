import 'package:flutter/material.dart';
import 'package:healtech/analytics/report_analytics.dart';
import 'package:healtech/appointment/appointment_scheduler.dart';
import 'package:healtech/medicine/medicine_scheduler.dart';
import 'package:healtech/profile/profile.dart';
import 'package:healtech/upload/upload_report.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final List<Widget> screens = <Widget>[
    const UploadReport(),
    const ReportAnalysis(),
    const MedicineScheduler(),
    const AppointmentScheduler(),
    const Profile(),
  ];

  void onTap(int index) {
    return setState(
      () {
        selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 80,
        height: 80,
        indicatorShape: const CircleBorder(
          eccentricity: 0.6,
        ),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedIndex,
        onDestinationSelected: onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.medical_information_outlined),
            selectedIcon: Icon(Icons.medical_information),
            label: "Report",
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: "Analysis",
          ),
          NavigationDestination(
            icon: Icon(Icons.medication_outlined),
            selectedIcon: Icon(Icons.medication),
            label: "Medicines",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: "Appointments",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
