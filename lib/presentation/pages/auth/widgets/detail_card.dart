import 'package:flutter/material.dart';
import 'package:healtech/core/sizes.dart';

class DetailCard extends StatefulWidget {
  final TextEditingController _controller;
  final TextInputType type;
  final String detail;
  const DetailCard({
    super.key,
    required TextEditingController controller,
    required this.detail,
    required this.type,
  }) : _controller = controller;

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    final InputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: Sizes.verySmall / 2,
      ),
    );
    return SizedBox(
      height: Sizes.detailCardHeight,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800]?.withOpacity(0.1),
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.cardBorderRadius),
            ),
          ),
          child: Row(
            children: [
              const Spacer(),
              SizedBox(
                height: Sizes.settingTileHeight,
                width: Sizes.profileCardHeight,
                child: TextField(
                  controller: widget._controller,
                  keyboardType: widget.type,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  enableSuggestions: false,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                widget.detail,
                style: const TextStyle(
                  fontSize: Sizes.mediumFont,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
