import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../auth/presentation/widgets/login_widgets/custom_button.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingModel model;
  final VoidCallback onPrimaryPressed;
  final VoidCallback? onBackPressed;

  const OnboardingPageWidget({
    super.key,
    required this.model,
    required this.onPrimaryPressed,
    this.onBackPressed,
  });

  bool get hasContainer => model.gradientColor != null;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(model.image, fit: BoxFit.cover),

          if (hasContainer)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    model.gradientColor!.withOpacity(0),
                    model.gradientColor!,
                  ],
                ),
              ),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: hasContainer
                ? _buildWithContainer()
                : _buildWithoutContainer(),
          ),
        ],
      ),
    );
  }

  Widget _buildWithoutContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.title,
              style: AppTextStyle.onBoardingScreenFrst,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.description,
              style: AppTextStyle.onBoardingScreenFrstDescription,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
              bottom: 26,
            ),
            child: CustomButton(
              text: model.buttonText,
              onPressed: onPrimaryPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            model.title,
            style: AppTextStyle.onBoardingScreenTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            model.description,
            style: AppTextStyle.onBoardingScreenDesc,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(text: model.buttonText, onPressed: onPrimaryPressed),
          if (model.showBackButton) ...[
            const SizedBox(height: 16),
            CustomButton(
              text: "Back",
              onPressed: onBackPressed!,
              backgroundColor: Colors.transparent,
              textColor: AppColor.yellow,
              borderColor: AppColor.yellow,
            ),
          ],
        ],
      ),
    );
  }
}
