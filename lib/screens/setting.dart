import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/service/auth/auth_service.dart';
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
            top: Sizes.small,
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
          padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingItem(
                icon: Icons.edit_rounded,
                text: "Edit Profile",
                onTap: () {
                  Navigator.of(context).pushNamed(editProfileRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              SettingItem(
                icon: Icons.security_rounded,
                text: "Security",
                onTap: () {
                  Navigator.of(context).pushNamed(securityRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              SettingItem(
                icon: Icons.notifications_rounded,
                text: "Notification",
                onTap: () {
                  Navigator.of(context).pushNamed(notificationRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              SettingItem(
                icon: Icons.privacy_tip_rounded,
                text: "Privacy",
                onTap: () {
                  Navigator.of(context).pushNamed(privacyRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              SettingItem(
                icon: Icons.help_rounded,
                text: "Help",
                onTap: () {
                  Navigator.of(context).pushNamed(helpRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              SettingItem(
                icon: Icons.question_answer_rounded,
                text: "About",
                onTap: () {
                  Navigator.of(context).pushNamed(aboutRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              SettingItem(
                icon: Icons.rule_rounded,
                text: "Terms and Policies",
                onTap: () {
                  Navigator.of(context).pushNamed(termAndPolicyRoute);
                },
              ),
              const SizedBox(height: Sizes.tileSpace),
              Center(
                child: SizedBox(
                  height: Sizes.buttonHeight,
                  width: Sizes.buttonWidth,
                  child: FilledButton(
                    onPressed: () async {
                      AuthService.signOut(context);
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: Sizes.mediumFont,
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
