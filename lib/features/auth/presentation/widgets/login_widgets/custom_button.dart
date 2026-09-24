import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final isNormanStyle;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColor.yellow,
    this.textColor = Colors.black,
    this.borderColor,
    this.isNormanStyle = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 2)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Builder(
          builder: (context) {
            final label = Text(
              text,
              style: !isNormanStyle
                  ? AppTextStyle.mainBtnTextStyle.copyWith(color: textColor)
                  : AppTextStyle.normalTextStyle.copyWith(color: textColor),
            );
            if (icon == null) return label;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                label,
                const SizedBox(width: 8),
                Icon(icon, color: textColor, size: 22),
              ],
            );
          },
        ),
      ),
    );
  }
}