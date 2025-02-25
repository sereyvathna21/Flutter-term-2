import 'package:flutter/material.dart';

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
    Color iconColor;
    switch (type) {
      case BlaIconType.secondary:
        iconColor = Colors.grey;
        break;
      case BlaIconType.primary:
        iconColor = Colors.blue;
        break;
    }

    return Icon(
      icon,
      color: color ?? iconColor, // Default color based on type
      size: size ?? 24.0, // Default size
    );
  }
}
