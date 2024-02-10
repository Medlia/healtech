import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtech/auth/email_verification.dart';
import 'package:healtech/auth/forget_password.dart';
// import 'package:healtech/auth/onboarding.dart';
import 'package:healtech/auth/signin.dart';
import 'package:healtech/auth/signup.dart';
import 'package:healtech/chat/chat.dart';
import 'package:healtech/firebase_options.dart';
import 'package:healtech/medicine/medicine_schedule.dart';
import 'package:healtech/navbar/navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
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
        '/forgetpassword': (context) => const ForgetPassword(),
        '/navbar': (context) => const NavBar(),
        '/medicineschedule': (context) => const MedicineSchedule(),
        '/chat': (context) => const Chat(),
      },
      home: const NavBar(),
    );
  }
}
