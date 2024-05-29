import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:healtech/core/sizes.dart';

class ImageCard extends StatelessWidget {
  final Uint8List bytes;
  const ImageCard({
    super.key,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.verySmall),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.fieldBorderRadius),
        child: Image.memory(
          bytes,
          width: double.infinity,
          height: Sizes.imageCardHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
