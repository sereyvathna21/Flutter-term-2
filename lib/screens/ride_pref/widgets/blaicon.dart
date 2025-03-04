import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

enum BlaIconType { primary, secondary }

class BlaIcon extends StatelessWidget {
  final IconData icon;
  final BlaIconType type;
  final Color? color;
  final double? size;

  const BlaIcon({
    super.key,
    required this.icon,
    this.type = BlaIconType.primary,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    // Define icon color based on type
    Color iconColor;
    switch (type) {
      case BlaIconType.secondary:
        iconColor =
            BlaColors.neutralLighter; // Use neutralLighter for secondary
        break;
      case BlaIconType.primary:
        iconColor = BlaColors.primary; // Use primary color for primary
        break;
    }

    return Icon(
      icon,
      color: color ?? iconColor, // Default color based on type
      size: size ?? BlaSpacings.l, // Default size from BlaSpacings
    );
  }
}
