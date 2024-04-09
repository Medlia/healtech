import 'package:flutter/material.dart';
import 'package:healtech/service/auth_service.dart';
import 'package:healtech/widgets/custom_textfield.dart';

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
            top: 8,
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
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
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
                const SizedBox(height: 4),
                Text(
                  "Enter your email and password to sign up",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _email,
                  icon: const Icon(Icons.email_rounded),
                  type: TextInputType.emailAddress,
                  enableSuggestions: false,
                  labelText: 'Email',
                  autoCorrect: false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _password,
                  icon: const Icon(Icons.lock_rounded),
                  type: TextInputType.text,
                  enableSuggestions: false,
                  obscureText: true,
                  labelText: 'Password',
                  autoCorrect: false,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      await AuthService.signup(
                        context,
                        _email.text,
                        _password.text,
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/signin',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Already have an account? Sign in here!",
                    style: TextStyle(
                      fontSize: 14,
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
