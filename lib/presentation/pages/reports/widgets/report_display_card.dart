import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/presentation/pages/reports/analyse.dart';

class ReportDisplayCard extends StatelessWidget {
  const ReportDisplayCard({
    super.key,
    required this.report,
  });

  final QueryDocumentSnapshot<Object?> report;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Analyze(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(Sizes.small),
        height: Sizes.medicineCardHeight / 2,
        child: Card(
          child: ListTile(
            title: Text(
              report['doctor\'s name'],
              style: const TextStyle(
                fontSize: Sizes.largeFont,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              report['department'],
              style: const TextStyle(
                fontSize: Sizes.mediumFont,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Text(
              '${report['reportURL'].length} images',
              style: const TextStyle(
                fontSize: Sizes.smallFont,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
