import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/screens/about.dart';
import 'package:healtech/screens/add_medicines.dart';
import 'package:healtech/screens/chat.dart';
import 'package:healtech/screens/edit_profile.dart';
import 'package:healtech/screens/email_verification.dart';
import 'package:healtech/screens/help.dart';
import 'package:healtech/screens/medicine_list.dart';
import 'package:healtech/screens/notification.dart';
import 'package:healtech/screens/onboarding.dart';
import 'package:healtech/screens/privacy.dart';
import 'package:healtech/screens/reset_password.dart';
import 'package:healtech/screens/medicine_schedule.dart';
import 'package:healtech/screens/navbar.dart';
import 'package:healtech/screens/security.dart';
import 'package:healtech/screens/setting.dart';
import 'package:healtech/screens/signin.dart';
import 'package:healtech/screens/signup.dart';
import 'package:healtech/screens/terms_and_policies.dart';
import 'package:healtech/screens/user_details.dart';
import 'package:healtech/providers/theme_provider.dart';
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
        addMedicineRoute: (context) => const AddMedicine(),
        medicineScheduleRoute: (context) => const MedicineSchedule(),
        medicineListRoute: (context) => const MedicineList(),
        chatRoute: (context) => const Chat(),
        settingRoute: (context) => const Setting(),
        editProfileRoute: (context) => const EditProfile(),
        securityRoute: (context) => const Security(),
        notificationRoute: (context) => const Notifications(),
        privacyRoute: (context) => const Privacy(),
        helpRoute: (context) => const Help(),
        aboutRoute: (context) => const About(),
        termAndPolicyRoute: (context) => const TermsAndPolicies(),
      },
      home: const OnBoarding(),
    );
  }
}
