import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_color.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.yellow),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColor.yellow,
                shape: BoxShape.circle,
              ),
              child: const Text("🇺🇸", style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text("🇪🇬", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
