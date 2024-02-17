import 'package:flutter/material.dart';

class DetailField extends StatefulWidget {
  final String title;
  final String hint;
  final int? maxLines;
  final TextInputType? type;
  final String? suffixText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  const DetailField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.type,
    this.suffixIcon,
    this.suffixText,
    this.maxLines,
  });

  @override
  State<DetailField> createState() => _DetailFieldState();
}

class _DetailFieldState extends State<DetailField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: widget.controller,
                  keyboardType: widget.type,
                  maxLines: widget.maxLines,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    suffixText: widget.suffixText,
                    suffixIcon: widget.suffixIcon,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
