import 'package:flutter/material.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static const List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'Find Your Next Favorite Movie Here',
      description: 'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      image: 'assets/onBoarding/mvpost1.png',
      buttonText: 'Explore Now',
    ),
    OnboardingModel(
      title: 'Discover Movies',
      description: 'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      image: 'assets/onBoarding/mvpost2.jpg',
      gradientColor: Color(0xFF084250),
      buttonText: 'Next',
    ),
    OnboardingModel(
      title: 'Explore All Genres',
      description: 'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      image: 'assets/onBoarding/mvpost3.jpg',
      gradientColor: Color(0xFF85210E),
      showBackButton: true,
      buttonText: 'Next',
    ),
    OnboardingModel(
      title: 'Create Watchlists',
      description: 'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      image: 'assets/onBoarding/mvpost4.jpg',
      gradientColor: Color(0xFF4C2471), // placeholder — swap for your real Figma color
      showBackButton: true,
      buttonText: 'Next',
    ),
    OnboardingModel(
      title: 'Rate, Review, and Learn',
      description: 'Share your thoughts on the movies you"ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      image: 'assets/onBoarding/mvpost5.jpg',
      gradientColor: Color(0xFF601321), // placeholder
      showBackButton: true,
      buttonText: 'Next',
    ),
    OnboardingModel(
      title: 'Start Watching Now',
      description: '',
      image: 'assets/onBoarding/mvpost6.jpg',
      gradientColor: Color(0xFF000000), // placeholder
      showBackButton: true,
      buttonText: 'Finish',
    ),
  ];
}