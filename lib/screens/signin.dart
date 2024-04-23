import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/screens/reset_password.dart';
import 'package:healtech/service/auth_service.dart';
import 'package:healtech/widgets/custom_textfield.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
                  controller: _email,
                  icon: const Icon(Icons.email_rounded),
                  type: TextInputType.emailAddress,
                  enableSuggestions: false,
                  obscureText: false,
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
                      if (!context.mounted) return;
                      await AuthService.signin(
                        context,
                        _email.text,
                        _password.text,
                      );
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ),
                    );
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
