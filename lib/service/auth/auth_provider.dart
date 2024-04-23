import 'package:healtech/service/auth/auth_user.dart';

// The UI shouldn't interact directly with the Firebase Functionalities
// The Firebase Authentication will be accessed using the Auth Provider and not directly used in our code
// Auth Service is going to have the implementation of the Auth Provider class which will be abstract

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;

  Future<AuthUser> signUp({
    required String email,
    required String password,
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendEmailVerification();

  Future<AuthUser> resetPassword({required String email});
}
