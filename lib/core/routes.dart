import 'package:flutter/material.dart';
import 'package:healtech/presentation/pages/auth/email_verification.dart';
import 'package:healtech/presentation/pages/auth/reset_password.dart';
import 'package:healtech/presentation/pages/auth/signin.dart';
import 'package:healtech/presentation/pages/auth/signup.dart';
import 'package:healtech/presentation/pages/auth/user_details.dart';
import 'package:healtech/presentation/pages/home/chat.dart';
import 'package:healtech/presentation/pages/medicine/add_medicines.dart';
import 'package:healtech/presentation/pages/medicine/medicine_list.dart';
import 'package:healtech/presentation/pages/medicine/medicine_schedule.dart';
import 'package:healtech/presentation/pages/navbar.dart';
import 'package:healtech/presentation/pages/profile/settings/about.dart';
import 'package:healtech/presentation/pages/profile/settings/edit_profile.dart';
import 'package:healtech/presentation/pages/profile/settings/help.dart';
import 'package:healtech/presentation/pages/profile/settings/notification.dart';
import 'package:healtech/presentation/pages/profile/settings/privacy.dart';
import 'package:healtech/presentation/pages/profile/settings/security.dart';
import 'package:healtech/presentation/pages/profile/settings/setting.dart';
import 'package:healtech/presentation/pages/profile/settings/terms_and_policies.dart';

const signInRoute = '/signin';
const signUpRoute = '/signup';
const verifyEmailRoute = '/verify';
const userDetailsRoute = '/userDetails';
const resetPasswordRoute = '/resetPassword';
const navBarRoute = '/navbar';
const medicineScheduleRoute = '/medicineSchedule';
const addMedicineRoute = '/addMedicine';
const medicineListRoute = '/medicineList';
const chatRoute = '/chat';
const settingRoute = '/setting';
const editProfileRoute = '/editProfile';
const securityRoute = '/security';
const notificationRoute = '/notification';
const privacyRoute = '/privacy';
const helpRoute = '/help';
const aboutRoute = '/about';
const termAndPolicyRoute = 'termPolicy';

Map<String, Widget Function(BuildContext context)> routes = {
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
};
