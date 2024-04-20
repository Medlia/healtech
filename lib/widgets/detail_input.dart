import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';

class DetailField extends StatefulWidget {
  final String title;
  final String hint;
  final TextInputType? type;
  final String? suffixText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool? readOnly;
  final TextCapitalization? textCapitalization;
  const DetailField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.type,
    this.suffixIcon,
    this.suffixText,
    this.readOnly,
    this.textCapitalization,
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
            fontSize: Sizes.largeFont,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Sizes.tileSpace / 2),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: Sizes.textFieldHeight,
                child: TextField(
                  controller: widget.controller,
                  keyboardType: widget.type,
                  readOnly: widget.readOnly ?? false,
                  textCapitalization:
                      widget.textCapitalization ?? TextCapitalization.none,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    suffixText: widget.suffixText,
                    suffixIcon: widget.suffixIcon,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Sizes.fieldBorderRadius),
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
