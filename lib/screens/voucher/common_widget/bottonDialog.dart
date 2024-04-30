import 'package:flutter/material.dart';

import '../common/color_extension.dart';

enum ButtonType { primary, textPrimary }

class Buttons extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final ButtonType type;
  const Buttons(
      {super.key,
      required this.title,
      this.type = ButtonType.primary,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: type == ButtonType.primary ? TColor.primary : TColor.white,
      minWidth: double.maxFinite,
      height: 44,
      shape: RoundedRectangleBorder(
          side: type == ButtonType.primary
              ? BorderSide.none
              : BorderSide(color: TColor.primary, width: 1.0),
          borderRadius: BorderRadius.circular(3)),
      child: Text(
        title,
        style: TextStyle(
            color:
                type == ButtonType.primary ? TColor.white : TColor.primary,
            fontSize: 16),
      ),
    );
  }
}
