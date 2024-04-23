import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/screens/chat.dart';
import 'package:healtech/screens/email_verification.dart';
import 'package:healtech/screens/reset_password.dart';
import 'package:healtech/screens/medicine_schedule.dart';
import 'package:healtech/screens/navbar.dart';
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
        signInRoute: (context) => const Signin(),
        signUpRoute: (context) => const SignUp(),
        verifyEmailRoute: (context) => const EmailVerify(
              email: '',
            ),
        userDetailsRoute: (context) => const UserDetails(),
        resetPasswordRoute: (context) => const ResetPassword(),
        navBarRoute: (context) => const NavBar(),
        medicineScheduleRoute: (context) => const MedicineSchedule(),
        chatRoute: (context) => const Chat(),
      },
      home: const NavBar(),
    );
  }
}
