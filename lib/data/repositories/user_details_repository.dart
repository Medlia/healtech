import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healtech/data/models/user_details_model.dart';
import 'package:healtech/service/auth/auth_service.dart';

class UserDetailsRepository {
  final FirebaseFirestore firestore;
  UserDetailsRepository(this.firestore);

  Future<void> saveUserDetails(UserDetailsModel userDetails) async {
    await firestore
        .collection('details')
        .doc(AuthService.firebase().currentUser!.uid)
        .set(userDetails.toJson());
  }
}
