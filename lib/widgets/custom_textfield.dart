import 'package:flutter/material.dart';

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
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        enableSuggestions: enableSuggestions,
        keyboardType: type,
        autocorrect: autoCorrect,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
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
