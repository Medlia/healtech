import 'package:flutter/material.dart';
import 'package:healtech/core/sizes.dart';

class MedicineDisplayCard extends StatelessWidget {
  const MedicineDisplayCard({
    super.key,
    required this.medicineData,
    this.width,
  });

  final Map<String, dynamic> medicineData;
  final double? width;

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

class HomeDisplayCard extends StatelessWidget {
  const HomeDisplayCard({
    super.key,
    required this.medicines,
  });

  final List<Map<String, dynamic>> medicines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.medicineCardHeight + 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var medicine in medicines.take(2))
            Container(
              padding: const EdgeInsets.all(Sizes.small),
              height: Sizes.medicineCardHeight,
              width: 390.0,
              child: Card(
                child: ListTile(
                  title: Text(
                    medicine['name'],
                    style: const TextStyle(
                      fontSize: Sizes.largeFont,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description: ${medicine['description']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                      Text(
                        'Doctor\'s Name: ${medicine['doctor\'s name']}',
                        style: const TextStyle(
                          fontSize: Sizes.mediumFont,
                        ),
                      ),
                      const SizedBox(height: Sizes.verySmall),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type: ${medicine['type']}',
                                style: const TextStyle(
                                  fontSize: Sizes.mediumFont,
                                ),
                              ),
                              Text(
                                'Dosage: ${medicine['dosage']} mg',
                                style: const TextStyle(
                                  fontSize: Sizes.mediumFont,
                                ),
                              ),
                              Text(
                                'Food Time: ${medicine['food time']}',
                                style: const TextStyle(
                                  fontSize: Sizes.mediumFont,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Duration: ${medicine['duration']}',
                                style: const TextStyle(
                                  fontSize: Sizes.mediumFont,
                                ),
                              ),
                              Text(
                                'Quantity: ${medicine['quantity']}',
                                style: const TextStyle(
                                  fontSize: Sizes.mediumFont,
                                ),
                              ),
                              Text(
                                'Time: ${medicine['time']}',
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
            ),
        ],
      ),
    );
  }
}

