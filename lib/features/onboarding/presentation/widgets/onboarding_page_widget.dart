import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    // Your design goes here: background image, gradient overlay using
    // model.gradientColor, rounded bottom container with title/description,
    // and the primary + back buttons wired to the callbacks above.
    throw UnimplementedError();
  }
}