import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AppointmentService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage() async {
    var selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    return selectedImage != null ? File(selectedImage.path) : null;
  }

  static Future<void> uploadImage(File? image) async {
    if (image != null) {
      String imageURL = '';
      await FirebaseFirestore.instance.collection('report').add(
        {
          'report': imageURL,
        },
      );
    }
  }
}
