import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../domain/entities/cast_member.dart';

class CastCard extends StatelessWidget {
  final CastMember member;

  const CastCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final photo = member.urlSmallImage;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 70,
              height: 70,
              child: photo != null && photo.isNotEmpty
                  ? Image.network(
                      photo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, color: AppColor.white, size: 40),
                    )
                  : const Icon(Icons.person, color: AppColor.white, size: 40),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: ${member.name}',
                  style: AppTextStyle.normalTextStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  'Character: ${member.characterName ?? '-'}',
                  style: AppTextStyle.normalTextStyle
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
