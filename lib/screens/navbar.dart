import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/screens/report_analysis.dart';
import 'package:healtech/screens/appointment_schedule.dart';
import 'package:healtech/screens/home.dart';
import 'package:healtech/screens/medicine_schedule.dart';
import 'package:healtech/screens/profile.dart';
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

  int selectedIndex = 0;

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
      appBar: AppBar(),
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: Sizes.tileSpace,
        height: Sizes.largestHeight,
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
              size: Sizes.mediumIcon,
            ),
            selectedIcon: Icon(
              Icons.home_rounded,
              size: Sizes.largeIcon,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.analytics_outlined,
              size: Sizes.mediumIcon,
            ),
            selectedIcon: Icon(
              Icons.analytics_rounded,
              size: Sizes.largeIcon,
            ),
            label: "Report Analysis",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.medication_outlined,
              size: Sizes.mediumIcon,
            ),
            selectedIcon: Icon(
              Icons.medication_rounded,
              size: Sizes.largeIcon,
            ),
            label: "Medicines",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_outlined,
              size: Sizes.mediumIcon,
            ),
            selectedIcon: Icon(
              Icons.calendar_month_rounded,
              size: Sizes.largeIcon,
            ),
            label: "Appointments",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outlined,
              size: Sizes.mediumIcon,
            ),
            selectedIcon: Icon(
              Icons.person_rounded,
              size: Sizes.largeIcon,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
