import 'package:flutter/material.dart';

class ReportAnalysis extends StatefulWidget {
  const ReportAnalysis({super.key});

  @override
  State<ReportAnalysis> createState() => _ReportAnalysisState();
}

class _ReportAnalysisState extends State<ReportAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Report Analysis",
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
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
