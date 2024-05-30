import 'package:flutter/material.dart';
import 'package:healtech/core/asset_strings.dart';
import 'package:healtech/core/sizes.dart';
import 'package:healtech/core/text_strings.dart';

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
              fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
            ),
          ),
          const SizedBox(height: Sizes.verySmall),
          Text(
            description ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
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
