import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';
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
            top: Sizes.small,
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
            padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Sizes.largerSpace),
                  Text(
                    "Tell us more about yourself",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineMedium?.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: Sizes.largeSpace),
                  DetailCard(
                    controller: _gender,
                    type: TextInputType.text,
                    detail: "Your Gender",
                  ),
                  const SizedBox(height: Sizes.sectionSpace),
                  DetailCard(
                    controller: _age,
                    type: TextInputType.number,
                    detail: "Your Age",
                  ),
                  const SizedBox(height: Sizes.sectionSpace),
                  DetailCard(
                    controller: _weight,
                    type: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    detail: "Your Weight",
                  ),
                  const SizedBox(height: Sizes.largeSpace),
                  SizedBox(
                    height: Sizes.buttonHeight,
                    width: Sizes.buttonWidth,
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
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/navbar',
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: Sizes.mediumFont,
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
