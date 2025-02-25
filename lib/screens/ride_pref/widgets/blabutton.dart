import 'package:flutter/material.dart';

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
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor:
          type == BlaButtonType.primary ? Colors.blue : Colors.white,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16.0),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: icon != null ? Icon(icon) : SizedBox.shrink(),
        label: Text(text),
      ),
    );
  }
}
