import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final TextInputType type;
  final bool autoCorrect;
  final bool enableSuggestions;
  final bool? obscureText;
  final String labelText;
  const CustomTextField({
    super.key,
    required this.icon,
    required this.type,
    required this.enableSuggestions,
    required this.controller,
    this.obscureText,
    required this.labelText,
    required this.autoCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        enableSuggestions: enableSuggestions,
        keyboardType: type,
        autocorrect: autoCorrect,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.outfit().toString(),
          ),
          icon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
