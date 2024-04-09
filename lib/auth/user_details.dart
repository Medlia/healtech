import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/widgets/detail_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Details",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
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
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
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
}
