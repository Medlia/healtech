import 'package:flutter/material.dart';
import 'package:healtech/service/auth_service.dart';
import 'package:healtech/widgets/custom_textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

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
            "Forget Password",
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
                  "Reset password",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Enter your email and we will send the reset instructions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _email,
                  icon: const Icon(Icons.email),
                  type: TextInputType.emailAddress,
                  enableSuggestions: false,
                  labelText: "Email",
                  autoCorrect: false,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      await AuthService.forgetPassword(
                        context,
                        _email.text,
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Reset email sent",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Reset password",
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
