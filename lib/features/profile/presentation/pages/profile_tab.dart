import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_route.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/service_locator.dart' as di;
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_movies_grid.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.signOutStatus == SignOutStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.loginRoute,
            (route) => false,
          );
        }
        if (state.signOutStatus == SignOutStatus.failure ||
            state.status == ProfileStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Something went wrong')),
          );
        }
      },
      builder: (context, state) {
        if (state.status == ProfileStatus.loading ||
            state.status == ProfileStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.yellow),
          );
        }

        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Column(
              children: [
                ProfileHeader(
                  user: state.user,
                  watchlistCount: state.watchlistCount,
                  historyCount: state.historyCount,
                  isSigningOut: state.signOutStatus == SignOutStatus.inProgress,
                  onEditProfile: () async {
                    await Navigator.pushNamed(
                      context,
                      AppRoute.updateProfileScreen,
                    );
                    if (context.mounted) {
                      context.read<ProfileCubit>().loadProfile();
                    }
                  },
                  onExit: () => context.read<ProfileCubit>().signOut(),
                ),
                ColoredBox(
                  color: AppColor.dark,
                  child: TabBar(
                    indicatorColor: AppColor.yellow,
                    // Run the indicator the full width of the tab.
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColor.white,
                    unselectedLabelColor: AppColor.white,
                    labelStyle: AppTextStyle.normalTextStyle,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.list, color: AppColor.yellow),
                        text: 'Watch List',
                      ),
                      Tab(
                        icon: Icon(Icons.folder, color: AppColor.yellow),
                        text: 'History',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ProfileMoviesGrid(movies: state.watchlist),
                      ProfileMoviesGrid(movies: state.history),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
