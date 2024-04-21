import 'package:cloud_firestore/cloud_firestore.dart';

class ReportAnalysisService {
  static final Stream<QuerySnapshot> reportSnapshots =
      FirebaseFirestore.instance.collection('reports').snapshots();
}

