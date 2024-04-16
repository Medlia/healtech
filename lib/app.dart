import 'package:flutter/material.dart';
import 'package:healtech/screens/chat.dart';
import 'package:healtech/screens/email_verification.dart';
import 'package:healtech/screens/forget_password.dart';
import 'package:healtech/screens/medicine_schedule.dart';
import 'package:healtech/screens/navbar.dart';
// import 'package:healtech/screens/onboarding.dart';
import 'package:healtech/screens/signin.dart';
import 'package:healtech/screens/signup.dart';
import 'package:healtech/screens/user_details.dart';
import 'package:healtech/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).theme,
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
      home: const NavBar(),
    );
  }
}
