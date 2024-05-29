import 'package:flutter/material.dart';
import 'package:healtech/core/sizes.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const SettingItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Sizes.settingTileHeight,
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: Sizes.small,
          bottom: Sizes.small,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[800]?.withOpacity(0.1),
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: Container(
          padding: const EdgeInsets.all(Sizes.small),
          child: Row(
            children: [
              Icon(
                icon,
                size: Sizes.largeIcon,
              ),
              const SizedBox(width: Sizes.sectionSpace),
              Text(
                text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: Sizes.largeFont,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                size: Sizes.largeIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
