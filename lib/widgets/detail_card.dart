import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final TextEditingController _controller;
  final String detail;
  const DetailCard({
    super.key,
    required TextEditingController controller,
    required this.detail,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 58,
              width: 54,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              detail,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
