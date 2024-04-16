import 'package:flutter/material.dart';
import 'package:healtech/constants/asset_strings.dart';
import 'package:healtech/constants/colors.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/constants/text_strings.dart';
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
    title: TextStrings.titleOne,
    description: TextStrings.descOne,
    image: AssetString.onBoardImageOne,
  ),
  Content(
    title: TextStrings.titleTwo,
    description: TextStrings.descTwo,
    image: AssetString.onBoardImageTwo,
  ),
  Content(
    title: TextStrings.titleThree,
    description: TextStrings.descThree,
    image: AssetString.onBoardImageThree,
  ),
  Content(
    title: TextStrings.titleFour,
    description: TextStrings.descFour,
    image: AssetString.onBoardImageFour,
  ),
];

class OnBoardingContent extends StatelessWidget {
  final String title;
  final String? description;
  final String image;
  const OnBoardingContent({
    Key? key,
    required this.title,
    this.description,
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
            ),
          ),
          const SizedBox(height: Sizes.verySmall),
          Text(
            description ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: Sizes.largeSpace),
          Image.asset(
            image,
            height: Sizes.onBoardImageHeight,
            width: Sizes.onBoardImageWidth,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final PageController _page;
  const DotIndicator({
    super.key,
    required PageController page,
  }) : _page = page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.small),
      height: Sizes.largestHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              _page.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: Sizes.mediumFont,
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: SmoothPageIndicator(
              controller: _page,
              count: 5,
              effect: const WormEffect(
                dotHeight: Sizes.tileSpace,
                dotWidth: Sizes.tileSpace,
                paintStyle: PaintingStyle.stroke,
                dotColor: CustomColors.primaryColor,
                activeDotColor: CustomColors.primaryAccentColor,
              ),
              onDotClicked: (index) => _page.animateToPage(
                index,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              ),
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              _page.nextPage(
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              "Next",
              style: TextStyle(
                fontSize: Sizes.mediumFont,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
