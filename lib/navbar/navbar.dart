import 'package:flutter/material.dart';
import 'package:healtech/analysis/report_analysis.dart';
import 'package:healtech/appointment/appointment_schedule.dart';
import 'package:healtech/home/home.dart';
import 'package:healtech/medicine/medicine_schedule.dart';
import 'package:healtech/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Widget> screens = <Widget>[
    const Home(),
    const ReportAnalysis(),
    const MedicineSchedule(),
    const Appointment(),
    const Profile(),
  ];

  late int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  Future<void> _loadSelectedIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  void _onTap(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedIndex', index);
    setState(() {
      selectedIndex = index;
    });
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
        onDestinationSelected: _onTap,
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
