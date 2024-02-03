import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/widgets/custom_textfield.dart';
import 'package:healtech/widgets/error_dialog.dart';

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
                    await _signup();
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

  Future<void> _signup() async {
    try {
      UserCredential userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user?.uid)
          .set(
        {
          'email': _email.text,
        },
      );
      if (!context.mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'invalid-email') {
        showErrorDialog(
          context,
          "Invalid email",
          "Enter a valid email address",
        );
      } else if (e.code == 'weak-password') {
        showErrorDialog(
          context,
          "Weak password",
          "Enter a password with more than 6 characters",
        );
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(
          context,
          "Email already in use",
          "Proceed to sign in using this email",
        );
      } else {
        showErrorDialog(
          context,
          "An exception occurred",
          e.toString(),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      showErrorDialog(
        context,
        "An exception occurred",
        e.toString(),
      );
    }
  }
}
