import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtech/core/routes.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/service/medicine_service.dart';
import 'package:healtech/presentation/pages/medicine/widgets/medicine_display_card.dart';
import 'package:healtech/presentation/pages/home/widgets/quote_display_card.dart';

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
          Navigator.of(context).pushNamed(chatRoute);
        },
        child: Container(
          height: Sizes.settingTileHeight,
          width: Sizes.settingTileHeight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.bubble_chart_sharp,
            size: Sizes.largerIcon,
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuoteDisplayCard(random: random),
              Container(
                padding: const EdgeInsets.all(Sizes.small),
                child: Row(
                  children: [
                    Text(
                      "Medicines",
                      style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontSize,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(medicineListRoute);
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize:
                              Theme.of(context).textTheme.labelLarge?.fontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: MedicineService.medicineSnapshots,
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No medicines added yet.'),
                    );
                  }
                  var medicines = snapshot.data!.docs
                      .map(
                          (medicine) => medicine.data() as Map<String, dynamic>)
                      .toList();

                  return HomeDisplayCard(medicines: medicines);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
