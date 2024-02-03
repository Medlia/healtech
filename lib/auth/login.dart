import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/widgets/custom_textfield.dart';
import 'package:healtech/widgets/error_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    await _login();
                  },
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/signup',
                    (route) => false,
                  );
                },
                child: const Text("Don't have an account? Signup here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      if (!context.mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        showErrorDialog(
          context,
          "User not found",
          "Sign up to create your account",
        );
      } else if (e.code == 'wrong-password') {
        showErrorDialog(
          context,
          "Wrong password",
          "Enter the right password to sign in",
        );
      } else {
        showErrorDialog(
          context,
          "An exception occurred",
          "Try signing in again",
        );
      }
    } catch (e) {
      showErrorDialog(
        context,
        "An exception occurred",
        "Try signing in again",
      );
    }
  }
}
