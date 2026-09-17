import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_text_style.dart';

/// Preliminary design: genre pills ("Action", "Drama", ...). Restyle freely.
class GenresWrap extends StatelessWidget {
  final List<String> genres;

  const GenresWrap({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: genres
          .map(
            (genre) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.gray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                genre,
                style: AppTextStyle.normalTextStyle.copyWith(fontSize: 16),
              ),
            ),
          )
          .toList(),
    );
  }
}
