import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:healtech/app.dart';
import 'package:healtech/constants/api_key.dart';
import 'package:healtech/firebase_options.dart';
import 'package:healtech/service/medication_service.dart';
import 'package:healtech/theme/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MedicationService.initializeNotification();
  Gemini.init(apiKey: APIConstant.apiKey);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
