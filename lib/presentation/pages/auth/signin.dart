import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtech/core/routes.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/presentation/controllers/auth/sign_in_controller.dart';
import 'package:healtech/service/auth/auth_exceptions.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:healtech/presentation/pages/auth/widgets/custom_textfield.dart';
import 'package:healtech/presentation/pages/auth/widgets/error_dialog.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.small,
          ),
          child: Text(
            "Sign in",
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
                  "Welcome back!",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Enter your email and password to sign in",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: Sizes.largeSpace),
                CustomTextField(
                  controller: controller.email,
                  icon: const Icon(Icons.email_rounded),
                  type: TextInputType.emailAddress,
                  enableSuggestions: false,
                  obscureText: false,
                  labelText: 'Email',
                  autoCorrect: false,
                ),
                const SizedBox(height: Sizes.tileSpace),
                CustomTextField(
                  controller: controller.password,
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
                      final email = controller.email.text;
                      final password = controller.password.text;
                      try {
                        await AuthService.firebase().signIn(
                          email: email,
                          password: password,
                        );
                        final user = AuthService.firebase().currentUser;
                        if (!context.mounted) return;
                        if (user!.isEmailVerified) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            navBarRoute,
                            (route) => false,
                          );
                        } else {
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                        }
                      } on UserNotFoundException {
                        showErrorDialog(
                          context,
                          "User not found",
                          "Sign up to create your account",
                        );
                      } on WrongPasswordException {
                        showErrorDialog(
                          context,
                          "Wrong password",
                          "Enter the right password to sign in",
                        );
                      } on GenericException {
                        showErrorDialog(
                          context,
                          "An exception occurred",
                          "Try signing in again",
                        );
                      }
                    },
                    child: const Text(
                      "Sign in",
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
                      signUpRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Don't have an account? Signup here!",
                    style: TextStyle(
                      fontSize: Sizes.smallFont,
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.tileSpace / 2),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(resetPasswordRoute);
                  },
                  child: const Text(
                    "Forgot password? Reset here!",
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
