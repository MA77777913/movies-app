
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class AdditionalDetails extends StatelessWidget {
  final String iconPath;
  final String likeCount;

  const AdditionalDetails({
    super.key,
    required this.iconPath,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF282A28),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Text(
            likeCount,
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}