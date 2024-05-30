import 'package:healtech/data/models/user_details_model.dart';
import 'package:healtech/data/repositories/user_details_repository.dart';

class SaveUserDetails {
  final UserDetailsRepository repository;
  SaveUserDetails(this.repository);

  Future<void> call(UserDetailsModel userDetails) {
    return repository.saveUserDetails(userDetails);
  }
}
