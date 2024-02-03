import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healtech/auth/login.dart';
import 'package:healtech/auth/onboarding.dart';
import 'package:healtech/auth/signup.dart';
import 'package:healtech/firebase_options.dart';
import 'package:healtech/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const Home(),
      },
      home: const OnBoarding(),
    );
  }
}
