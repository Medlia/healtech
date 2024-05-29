import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healtech/service/medicine_service.dart';
import 'package:healtech/presentation/pages/medicine/widgets/medicine_display_card.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Medicines",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: StreamBuilder<QuerySnapshot>(
            stream: MedicineService.orderedMedicineSnapshots,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No medicines added yet.'),
                );
              }
              var medicines = snapshot.data!.docs
                  .map((medicine) => medicine.data() as Map<String, dynamic>)
                  .toList();

              return ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  var medicineData = medicines[index];
                  return MedicineDisplayCard(medicineData: medicineData);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
