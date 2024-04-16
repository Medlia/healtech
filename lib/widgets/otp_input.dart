import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healtech/constants/sizes.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.otpInputHeight,
      width: Sizes.otpInputWidth,
      child: TextField(
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.fieldBorderRadius),
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
