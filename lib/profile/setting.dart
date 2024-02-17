import 'package:flutter/material.dart';
import 'package:healtech/profile/about.dart';
import 'package:healtech/profile/edit_profile.dart';
import 'package:healtech/profile/help.dart';
import 'package:healtech/profile/notification.dart';
import 'package:healtech/profile/privacy.dart';
import 'package:healtech/profile/security.dart';
import 'package:healtech/profile/terms_and_policies.dart';
import 'package:healtech/service/auth_service.dart';
import 'package:healtech/widgets/setting_item.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Settings",
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
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingItem(
                icon: Icons.edit_rounded,
                text: "Edit Profile",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.security_rounded,
                text: "Security",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Security(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.notifications_rounded,
                text: "Notification",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.privacy_tip_rounded,
                text: "Privacy",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Privacy(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.help_rounded,
                text: "Help",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Help(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.question_answer_rounded,
                text: "About",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.rule_rounded,
                text: "Terms and Policies",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TermsAndPolicies(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  height: 45,
                  width: 200,
                  child: FilledButton(
                    onPressed: () async {
                      AuthService.signOut(context);
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
