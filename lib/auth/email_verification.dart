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
            top: 8,
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
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
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
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    await AuthService.emailVerification(context);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onInverseSurface,
                        content: Text(
                          "Verification email sent",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
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
                  height: 45,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      User user = FirebaseAuth.instance.currentUser!;
                      user.reload();
                      user = FirebaseAuth.instance.currentUser!;
                      if (!context.mounted) return;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/userdetails',
                        (route) => false,
                      );
                      {
                        if (!context.mounted) return;
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
                                fontSize: 16,
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
