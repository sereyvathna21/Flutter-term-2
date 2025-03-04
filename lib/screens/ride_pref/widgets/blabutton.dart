import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'blaicon.dart'; // Import the BlaIcon

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final BlaButtonType type;
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.type,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Define button style based on type
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor:
          type == BlaButtonType.primary ? BlaColors.primary : BlaColors.white,
      foregroundColor: type == BlaButtonType.primary
          ? BlaColors.white
          : BlaColors.neutralDark,
      padding: EdgeInsets.symmetric(vertical: BlaSpacings.m),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: icon != null
            ? BlaIcon(
                icon: icon!,
                type: type == BlaButtonType.primary
                    ? BlaIconType.primary
                    : BlaIconType.secondary,
              )
            : const SizedBox.shrink(),
        label: Text(
          text,
          style: BlaTextStyles.button.copyWith(
            color: type == BlaButtonType.primary
                ? BlaColors.white
                : BlaColors.neutralDark,
          ),
        ),
      ),
    );
  }
}
