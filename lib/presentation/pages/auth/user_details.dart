import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healtech/domain/usecases/save_user_details.dart';
import 'package:healtech/presentation/controllers/auth/user_details_controller.dart';
import 'package:healtech/core/routes.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/presentation/pages/auth/widgets/detail_card.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final UserDetailsController controller =
      Get.put(UserDetailsController(Get.find<SaveUserDetails>()));

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
                    controller: controller.gender,
                    type: TextInputType.text,
                    detail: "Your Gender",
                  ),
                  const SizedBox(height: Sizes.sectionSpace),
                  DetailCard(
                    controller: controller.age,
                    type: TextInputType.number,
                    detail: "Your Age",
                  ),
                  const SizedBox(height: Sizes.sectionSpace),
                  DetailCard(
                    controller: controller.weight,
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
                        await controller.saveDetails();
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          navBarRoute,
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
