import 'package:flutter/material.dart';
import 'package:healtech/core/colors.dart';
import 'package:healtech/core/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotIndicator extends StatelessWidget {
  final PageController page;

  const DotIndicator({
    super.key,
    required this.page,
  });

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
              page.previousPage(
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
              controller: page,
              count: 5,
              effect: const WormEffect(
                dotHeight: Sizes.tileSpace,
                dotWidth: Sizes.tileSpace,
                paintStyle: PaintingStyle.stroke,
                dotColor: CustomColors.primaryColor,
                activeDotColor: CustomColors.primaryAccentColor,
              ),
              onDotClicked: (index) => page.animateToPage(
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
              page.nextPage(
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
