import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/service/auth/auth_exceptions.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:healtech/widgets/custom_textfield.dart';
import 'package:healtech/widgets/error_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.small,
          ),
          child: Text(
            "Sign up",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Enter your email and password to sign up",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: Sizes.largeSpace),
                CustomTextField(
                  controller: _email,
                  icon: const Icon(Icons.email_rounded),
                  type: TextInputType.emailAddress,
                  enableSuggestions: false,
                  labelText: 'Email',
                  autoCorrect: false,
                ),
                const SizedBox(height: Sizes.tileSpace),
                CustomTextField(
                  controller: _password,
                  icon: const Icon(Icons.lock_rounded),
                  type: TextInputType.text,
                  enableSuggestions: false,
                  obscureText: true,
                  labelText: 'Password',
                  autoCorrect: false,
                ),
                const SizedBox(height: Sizes.sectionSpace),
                SizedBox(
                  height: Sizes.buttonHeight,
                  width: Sizes.buttonWidth,
                  child: FilledButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await AuthService.firebase().signUp(
                          email: email,
                          password: password,
                        );
                        final user = AuthService.firebase().currentUser;
                        if (!context.mounted) return;
                        if (user!.isEmailVerified) {
                          Navigator.of(context).pushNamed(userDetailsRoute);
                        } else {
                          AuthService.firebase().sendEmailVerification();
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                        }
                      } on InvalidEmailException {
                        showErrorDialog(
                          context,
                          "Invalid email",
                          "Enter a valid email address",
                        );
                      } on WeakPasswordException {
                        showErrorDialog(
                          context,
                          "Weak password",
                          "Enter a password with more than 6 characters",
                        );
                      } on EmailAlreadyInUseException {
                        showErrorDialog(
                          context,
                          "Email already in use",
                          "Proceed to sign in using this email",
                        );
                      } on GenericException {
                        showErrorDialog(
                          context,
                          "An exception occurred",
                          "Try signing up again",
                        );
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: Sizes.mediumFont,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.textSpace),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      signInRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Already have an account? Sign in here!",
                    style: TextStyle(
                      fontSize: Sizes.smallFont,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
