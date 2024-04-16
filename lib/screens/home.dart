import 'dart:math';
import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/screens/chat.dart';
import 'package:healtech/constants/text_strings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int random = Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Chat(),
            ),
          );
        },
        child: Draggable(
          feedback: Container(
            height: Sizes.settingTileHeight,
            width: Sizes.settingTileHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bubble_chart_rounded,
              size: Sizes.largerIcon,
            ),
          ),
          child: Container(
            height: Sizes.settingTileHeight,
            width: Sizes.settingTileHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bubble_chart_sharp,
              size: Sizes.largerIcon,
            ),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.small,
          ),
          child: Text(
            "Home",
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
          padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              ),
              Container(
                padding: const EdgeInsets.all(Sizes.small),
                child: Text(
                  "Medicines",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                  ),
                ),
              ),
              const SizedBox(height: Sizes.medium),
            ],
          ),
        ),
      ),
    );
  }
}
