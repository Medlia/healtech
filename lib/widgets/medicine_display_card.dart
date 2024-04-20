import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';

class MedicineDisplayCard extends StatelessWidget {
  const MedicineDisplayCard({
    super.key,
    required this.medicineData,
  });

  final Map<String, dynamic> medicineData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.small),
      height: Sizes.medicineCardHeight,
      child: Card(
        child: ListTile(
          title: Text(
            medicineData['name'],
            style: const TextStyle(
              fontSize: Sizes.largeFont,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description: ${medicineData['description']}',
                style: const TextStyle(
                  fontSize: Sizes.mediumFont,
                ),
              ),
              Text(
                'Doctor\'s Name: ${medicineData['doctor\'s name']}',
                style: const TextStyle(
                  fontSize: Sizes.mediumFont,
                ),
              ),
              const SizedBox(height: Sizes.verySmall),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type: ${medicineData['type']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                      Text(
                        'Dosage: ${medicineData['dosage']} mg',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                      Text(
                        'Food Time: ${medicineData['food time']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration: ${medicineData['duration']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                      Text(
                        'Quantity: ${medicineData['quantity']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                      Text(
                        'Time: ${medicineData['time']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
