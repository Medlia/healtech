import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:healtech/app.dart';
import 'package:healtech/data/repositories/user_details_repository.dart';
import 'package:healtech/domain/usecases/save_user_details.dart';
import 'package:healtech/firebase_options.dart';
import 'package:healtech/presentation/providers/theme_provider.dart';
import 'package:healtech/src/api_key.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Get.put(UserDetailsRepository(firestore));
  Get.put(SaveUserDetails(Get.find<UserDetailsRepository>()));
  Gemini.init(apiKey: apiKey);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
