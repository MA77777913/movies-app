import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../../../auth/domain/entities/user_entity.dart';

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

    return Container(
      color: AppColor.dark,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: 92,
                      width: 92,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(avatar),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.name ?? 'John Safwat',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: _Counter(count: watchlistCount, label: 'Wish List'),
              ),
              Expanded(
                flex: 3,
                child: _Counter(count: historyCount, label: 'History'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onEditProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.yellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isSigningOut ? () {} : onExit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.exit_to_app_rounded, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
