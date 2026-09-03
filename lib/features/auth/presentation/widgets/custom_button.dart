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

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColor.yellow,
    this.textColor = Colors.black,
    this.borderColor,
    this.isNormanStyle = false
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
          elevation: 0, // Removes shadow to keep the outline clean
        ),
        child: Text(
          text,
          style: !isNormanStyle ? AppTextStyle.mainBtnTextStyle.copyWith(
            color: textColor,
          ) : AppTextStyle.normalTextStyle.copyWith(color: textColor)
        ),
      ),
    );
  }
}