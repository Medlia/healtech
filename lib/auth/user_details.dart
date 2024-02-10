import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/navbar/navbar.dart';
import 'package:healtech/widgets/detail_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late final TextEditingController _gender;
  late final TextEditingController _age;
  late final TextEditingController _weight;

  @override
  void initState() {
    _gender = TextEditingController();
    _age = TextEditingController();
    _weight = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _gender.dispose();
    _age.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<bool> onUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isUserDetails') ?? false;
  }

  void _onDetailsTaken(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserDetails', true);

    await FirebaseFirestore.instance
        .collection('details')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'gender': _gender.text,
        'age': _age.text,
        'weight': _weight.text,
      },
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const NavBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final bool onUserDetails = snapshot.data ?? false;
          return onUserDetails
              ? const NavBar()
              : Scaffold(
                  appBar: AppBar(
                    title: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Details",
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              Text(
                                "Tell us more about yourself",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 30),
                              DetailCard(
                                controller: _gender,
                                type: TextInputType.text,
                                detail: "Your Gender",
                              ),
                              const SizedBox(height: 20),
                              DetailCard(
                                controller: _age,
                                type: TextInputType.number,
                                detail: "Your Age",
                              ),
                              const SizedBox(height: 20),
                              DetailCard(
                                controller: _weight,
                                type: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                detail: "Your Weight",
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 45,
                                width: 200,
                                child: FilledButton(
                                  onPressed: () async {
                                    _onDetailsTaken(context);
                                  },
                                  child: const Text(
                                    "Next",
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
                  ),
                );
        }
      },
    );
  }
}
