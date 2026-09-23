import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/widgets/login_widgets/custom_button.dart';

/// Preliminary design: avatar and name on the left, the two counters beside
/// them, then the Edit Profile / Exit buttons.
class ProfileHeader extends StatelessWidget {
  final UserEntity? user;
  final int watchlistCount;
  final int historyCount;
  final bool isSigningOut;
  final VoidCallback onEditProfile;
  final VoidCallback onExit;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.watchlistCount,
    required this.historyCount,
    required this.isSigningOut,
    required this.onEditProfile,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = user?.avatar.isNotEmpty == true
        ? user!.avatar
        : AppAssets.avatars.first;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(avatar),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user?.name ?? '',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.titleMovieDetails.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _Counter(count: watchlistCount, label: 'Wish List'),
              ),
              Expanded(
                child: _Counter(count: historyCount, label: 'History'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomButton(
                  isNormanStyle: true,
                  onPressed: onEditProfile,
                  text: 'Edit Profile',
                  backgroundColor: AppColor.yellow,
                  textColor: AppColor.black,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: CustomButton(
                  isNormanStyle: true,
                  onPressed: isSigningOut ? () {} : onExit,
                  text: 'Exit',
                  backgroundColor: AppColor.red,
                  textColor: AppColor.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  final int count;
  final String label;

  const _Counter({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: AppTextStyle.titleMovieDetails.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyle.normalTextStyle.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
