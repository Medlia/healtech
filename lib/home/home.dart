import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healtech/chat/chat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> healthQuotes = [
    "Health is the greatest possession. Contentment is the greatest treasure. Confidence is the greatest friend.",
    "The only way to keep your health is to eat what you don't want, drink what you don't like, and do what you'd rather not.",
    "The human body has been designed to resist an infinite number of changes and attacks brought about by its environment.",
    "The groundwork of all happiness is health.",
    "The doctor of the future will no longer treat the human frame with drugs, but rather will cure and prevent disease with nutrition.",
    "Good health and good sense are two of life's greatest blessings.",
    "Take care of your body. It's the only place you have to live.",
    "To keep the body in good health is a duty, otherwise we shall not be able to keep our mind strong and clear.",
    "A man too busy to take care of his health is like a mechanic too busy to take care of his tools",
    "It is health that is real wealth and not pieces of gold and silver.",
  ];
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
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bubble_chart_rounded,
              size: 50,
            ),
          ),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bubble_chart_sharp,
              size: 50,
            ),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
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
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Card(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.health_and_safety_rounded,
                              size: 30,
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                healthQuotes[random],
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 20,
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Medicines",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
