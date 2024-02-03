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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Create your account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _email,
                icon: const Icon(Icons.email),
                type: TextInputType.emailAddress,
                enableSuggestions: false,
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
                    await AuthService.signup(
                      context,
                      _email.text,
                      _password.text,
                    );
                  },
                  child: const Text("Sign up"),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text("Already have an account? Login here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
