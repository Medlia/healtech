import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/constants/text_strings.dart';

class QuoteDisplayCard extends StatelessWidget {
  const QuoteDisplayCard({
    super.key,
    required this.random,
  });

  final int random;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.medicineCardHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(Sizes.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.cardBorderRadius),
      ),
      child: Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.small),
          child: Row(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.health_and_safety_rounded,
                    size: Sizes.largeIcon,
                  ),
                ],
              ),
              const SizedBox(width: Sizes.medium),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TextStrings.healthQuotes[random],
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: Sizes.largerFont,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
