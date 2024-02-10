import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Uint8List bytes;
  const ImageCard({
    super.key,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          bytes,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
