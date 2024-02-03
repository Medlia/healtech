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
  final List<Widget> screens = <Widget>[
    const UploadReport(),
    const ReportAnalysis(),
    const MedicineScheduler(),
    const AppointmentScheduler(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: screens),
    );
  }
}
