import 'package:flutter/material.dart';
import 'package:healtech/analysis/report_analysis.dart';
import 'package:healtech/appointment/appointment_schedule.dart';
import 'package:healtech/home/home.dart';
import 'package:healtech/medicine/medicine_schedule.dart';
import 'package:healtech/profile/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  final List<Widget> screens = <Widget>[
    const Home(),
    const ReportAnalysis(),
    const MedicineSchedule(),
    const Appointment(),
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
            icon: Icon(
              Icons.home_outlined,
              size: 28,
            ),
            selectedIcon: Icon(
              Icons.home_rounded,
              size: 34,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.analytics_outlined,
              size: 28,
            ),
            selectedIcon: Icon(
              Icons.analytics_rounded,
              size: 34,
            ),
            label: "Report Analysis",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.medication_outlined,
              size: 28,
            ),
            selectedIcon: Icon(
              Icons.medication_rounded,
              size: 34,
            ),
            label: "Medicines",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_outlined,
              size: 28,
            ),
            selectedIcon: Icon(
              Icons.calendar_month_rounded,
              size: 34,
            ),
            label: "Appointments",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outlined,
              size: 28,
            ),
            selectedIcon: Icon(
              Icons.person_rounded,
              size: 34,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
