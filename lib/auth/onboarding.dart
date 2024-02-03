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
    checkOnboardingStatus();
  }

  checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    if (onboardingCompleted) {
      navigateToSignupScreen();
    }
  }

  navigateToSignupScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
    navigateToSignupScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
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
            ],
          ),
        ),
      ),
      bottomSheet: DotIndicator(
        page: _page,
        onComplete: completeOnboarding,
      ),
    );
  }
}
