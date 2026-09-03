import 'package:flutter/material.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static const List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'Find your next favorite movie',
      description: 'Browse thousands of movies picked just for you.',
      image: 'assets/images/onboarding_1.png',
      buttonText: 'Explore Now',
    ),
    OnboardingModel(
      title: 'Track what you love',
      description: 'Save movies to your watchlist.',
      image: 'assets/images/onboarding_2.png',
      gradientColor: Color(0xFF084250),
      showBackButton: true,
      buttonText: 'Next',
    ),
    OnboardingModel(
      title: 'Get personalized picks',
      description: 'We suggest movies based on what you enjoy.',
      image: 'assets/images/onboarding_3.png',
      gradientColor: Color(0xFF85210E),
      showBackButton: true,
      buttonText: 'Finish',
    ),
  ];
}