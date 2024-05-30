import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healtech/data/models/appointment_model.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:path/path.dart' as path;

class AppointmentRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  AppointmentRepository(this.firestore, this.storage);

  Future<void> saveAppointmentDetails(AppointmentModel appointment) async {
    await firestore
        .collection('appointment')
        .doc(AuthService.firebase().currentUser?.uid)
        .collection('entries')
        .add(appointment.toJson());
  }

  Future<String?> uploadFile(File file, String folder) async {
    try {
      final fileName = path.basename(file.path);
      final destination = '$folder/$fileName';
      final Reference storageReference = storage.ref().child(destination);
      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
