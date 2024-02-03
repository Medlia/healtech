import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtech/auth/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Content {
  final String title;
  final String description;
  final String image;

  Content({
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<Content> content = [
  Content(
    title: "Meet MedLia",
    description: "Your Personalized Healthcare Assistant",
    image: 'assets/assistant1.png',
  ),
  Content(
    title: "Never miss a dosage",
    description: "MedLia helps you stays on track with your medicines",
    image: 'assets/medicine.png',
  ),
  Content(
    title: "Confused about anything?",
    description: "MedLia clarifies every doubt you may have",
    image: 'assets/doubt.png',
  ),
  Content(
    title: "Efficient report management",
    description:
        "Handle your reports efficiently and get analyses, all in one place",
    image: 'assets/report.png',
  ),
];

class OnBoardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const OnBoardingContent({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
              fontFamily: GoogleFonts.outfit().toString(),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.outfit().toString(),
            ),
          ),
          const SizedBox(height: 40),
          Image.asset(
            image,
            height: 200,
            width: 200,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required PageController page,
  }) : _page = page;

  final PageController _page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
            },
            child: const Text("Skip"),
          ),
          const Spacer(),
          Center(
            child: SmoothPageIndicator(
              controller: _page,
              count: 4,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                paintStyle: PaintingStyle.stroke,
                dotColor: Theme.of(context).colorScheme.onSecondaryContainer,
                activeDotColor: Theme.of(context).colorScheme.secondary,
              ),
              onDotClicked: (index) => _page.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              _page.nextPage(
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: const Text("Next"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
