import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;
  final Color? gradientColor; // null on screen 1 — no overlay there
  final bool showBackButton;
  final String buttonText; // "Explore Now" / "Next" / "Finish"

  const OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
    this.gradientColor,
    this.showBackButton = false,
    required this.buttonText,
  });
}