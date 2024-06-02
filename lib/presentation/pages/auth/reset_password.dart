import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/presentation/controllers/auth/reset_password_controller.dart';
import 'package:healtech/service/auth/auth_service.dart';
import 'package:healtech/presentation/pages/auth/widgets/custom_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ResetPassword> {
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.small,
          ),
          child: Text(
            "Reset Password",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Reset password",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: Sizes.verySmall),
                Text(
                  "Enter your email and we will send the reset instructions",
                  textAlign: TextAlign.center,
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
                  labelText: "Email",
                  autoCorrect: false,
                ),
                const SizedBox(height: Sizes.sectionSpace),
                SizedBox(
                  height: Sizes.buttonHeight,
                  width: Sizes.buttonWidth,
                  child: FilledButton(
                    onPressed: () async {
                      final email = controller.email.text;
                      await AuthService.firebase().resetPassword(
                        email: email,
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          content: Text(
                            "Reset email sent",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                              fontSize: Sizes.mediumFont,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Reset password",
                      style: TextStyle(
                        fontSize: Sizes.mediumFont,
                      ),
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
