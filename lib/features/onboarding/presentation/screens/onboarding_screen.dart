import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_color.dart';
import '../../../../core/utils/app_route.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        _pageController.animateToPage(
          state.currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return Scaffold(
          backgroundColor: AppColor.black,
          body: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // buttons drive navigation, not swipes
            itemCount: cubit.pages.length,
            itemBuilder: (context, index) {
              final model = cubit.pages[index];
              return OnboardingPageWidget(
                model: model,
                onBackPressed: model.showBackButton ? cubit.previousPage : null,
                onPrimaryPressed: () {
                  if (cubit.isLastPage) {
                    Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
                  } else {
                    cubit.nextPage();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}