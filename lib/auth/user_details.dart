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
            left: 16,
            top: 16,
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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Tell us more about yourself",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
                DetailCard(controller: _gender, detail: "Your Gender"),
                const SizedBox(height: 20),
                DetailCard(
                  controller: _age,
                  detail: "Your Age",
                ),
                const SizedBox(height: 20),
                DetailCard(
                  controller: _weight,
                  detail: "Your Weight",
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {},
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
    );
  }
}
