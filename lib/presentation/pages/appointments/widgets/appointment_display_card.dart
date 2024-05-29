import 'package:flutter/material.dart';
import 'package:healtech/core/sizes.dart';

class AppointmentDisplayCard extends StatelessWidget {
  const AppointmentDisplayCard({
    super.key,
    required this.appointmentData,
  });

  final Map<String, dynamic> appointmentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.small),
      height: Sizes.reportCardHeight,
      child: Card(
        child: ListTile(
          title: Text(
            appointmentData['doctor\'s name'],
            style: const TextStyle(
              fontSize: Sizes.largerFont,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Description: ${appointmentData['description']}',
                style: const TextStyle(
                  fontSize: Sizes.mediumFont,
                ),
              ),
              Text(
                'Time: ${appointmentData['time']}',
                style: const TextStyle(
                  fontSize: Sizes.mediumFont,
                ),
              ),
              Text(
                'Date: ${appointmentData['date']}',
                style: const TextStyle(
                  fontSize: Sizes.mediumFont,
                ),
              ),
              const SizedBox(height: Sizes.tileSpace),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Theme.of(context)
                            .colorScheme
                            .scrim,
                        builder:
                            (BuildContext context) {
                          return Dialog(
                            child: Image.network(
                              appointmentData[
                                  'reports'],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    },
                    child: Image.network(
                      appointmentData['reports'],
                      height: Sizes.imageHeight,
                      width: Sizes.imageWidth,
                      fit: BoxFit.fill,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Theme.of(context)
                            .colorScheme
                            .scrim,
                        builder:
                            (BuildContext context) {
                          return Dialog(
                            child: Image.network(
                              appointmentData[
                                  'prescription'],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    },
                    child: Image.network(
                      appointmentData['prescription'],
                      height: Sizes.imageHeight,
                      width: Sizes.imageWidth,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
