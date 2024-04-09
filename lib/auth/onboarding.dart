import 'package:flutter/material.dart';
import 'package:healtech/auth/signup.dart';
import 'package:healtech/widgets/onboarding_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  OnBoardingState createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  late final PageController _page;
  bool isLastPage = false;

  @override
  void initState() {
    _page = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  void _onIntroEnd(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnBoardingShown', true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  body: SafeArea(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                      child: PageView(
                        controller: _page,
                        children: [
                          OnBoardingContent(
                            title: content[0].title,
                            description: content[0].description,
                            image: content[0].image,
                          ),
                          OnBoardingContent(
                            title: content[1].title,
                            description: content[1].description,
                            image: content[1].image,
                          ),
                          OnBoardingContent(
                            title: content[2].title,
                            description: content[2].description,
                            image: content[2].image,
                          ),
                          OnBoardingContent(
                            title: content[3].title,
                            description: content[3].description,
                            image: content[3].image,
                          ),
                          Column(
                            children: [
                              const Spacer(),
                              Text(
                                "HealTech",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.fontSize,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Image.asset(
                                'assets/onboard_logo.png',
                                height: 200,
                                width: 200,
                              ),
                              TextButton(
                                onPressed: () {
                                  _onIntroEnd(context);
                                },
                                child: const Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomSheet: DotIndicator(page: _page),
                );
  }
}
