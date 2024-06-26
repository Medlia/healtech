import 'package:flutter/material.dart';
import 'package:healtech/core/routes.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/service/auth/auth_service.dart';

class EmailVerify extends StatefulWidget {
  final String email;
  const EmailVerify({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.small,
          ),
          child: Text(
            "Email Verification",
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
                  "Verify your email",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "The verification email has been sent. Please check your inbox.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "If you have not received the email, tap the button below to receive the email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onInverseSurface,
                        content: Text(
                          "Verification email sent",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontSize: Sizes.mediumFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Send verification email",
                    style: TextStyle(
                      fontSize: Sizes.mediumFont,
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.tileSpace),
                SizedBox(
                  height: Sizes.buttonHeight,
                  width: Sizes.buttonWidth,
                  child: FilledButton(
                    onPressed: () async {
                      var user = AuthService.firebase().currentUser;
                      await AuthService.firebase().reloadCurrentUser();
                      user = AuthService.firebase().currentUser;
                      if (!context.mounted) return;
                      if (user!.isEmailVerified) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          userDetailsRoute,
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.onInverseSurface,
                            content: Text(
                              "Verify email before proceeding",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface,
                                fontSize: Sizes.mediumFont,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Verify status",
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
