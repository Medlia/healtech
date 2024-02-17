import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtech/auth/email_verification.dart';
import 'package:healtech/auth/forget_password.dart';
import 'package:healtech/auth/onboarding.dart';
import 'package:healtech/auth/signin.dart';
import 'package:healtech/auth/signup.dart';
import 'package:healtech/auth/user_details.dart';
import 'package:healtech/chat/chat.dart';
import 'package:healtech/firebase_options.dart';
import 'package:healtech/medicine/medicine_schedule.dart';
import 'package:healtech/navbar/navbar.dart';
import 'package:healtech/service/medication_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MedicationService.initializeNotification();
  Gemini.init(apiKey: 'AIzaSyAvubAUBG3xVXZZ5GlIMUa3jJA4JMOIKY8');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routes: {
        '/signin': (context) => const Signin(),
        '/signup': (context) => const SignUp(),
        '/verify': (context) => const EmailVerify(
              email: '',
            ),
        '/userdetails': (context) => const UserDetails(),
        '/forgetpassword': (context) => const ForgetPassword(),
        '/navbar': (context) => const NavBar(),
        '/medicineschedule': (context) => const MedicineSchedule(),
        '/chat': (context) => const Chat(),
      },
      home: const OnBoarding(),
    );
  }
}
