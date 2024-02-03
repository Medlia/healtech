import 'package:flutter/material.dart';
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
            left: 16,
            top: 16,
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
          padding: const EdgeInsets.all(16),
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Enter your email and password to sign in",
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
                  obscureText: false,
                  labelText: 'Email',
                  autoCorrect: false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _password,
                  icon: const Icon(Icons.lock),
                  type: TextInputType.text,
                  enableSuggestions: false,
                  obscureText: true,
                  labelText: 'Password',
                  autoCorrect: false,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      await AuthService.signin(
                        context,
                        _email.text,
                        _password.text,
                      );
                    },
                    child: const Text(
                      "Sign in",
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
                      '/signup',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Don't have an account? Signup here!",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/forgetpassword',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Forgot password? Reset here!",
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
