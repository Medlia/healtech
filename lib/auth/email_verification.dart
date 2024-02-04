import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/service/auth_service.dart';

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
            left: 16,
            top: 16,
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
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Verify your email",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    await AuthService.emailVerification(context);
                  },
                  child: const Text(
                    "Send verification email",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      User user = FirebaseAuth.instance.currentUser!;
                      user.reload();
                      user = FirebaseAuth.instance.currentUser!;
                      if (user.emailVerified) {
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/navbar',
                          (route) => false,
                        );
                      } else {
                         if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Verify email before proceeding",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Verify status",
                      style: TextStyle(
                        fontSize: 16,
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
