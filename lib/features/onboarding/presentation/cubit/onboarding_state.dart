class OnboardingState {
  final int currentPage;
  const OnboardingState({required this.currentPage});

  factory OnboardingState.initial() => const OnboardingState(currentPage: 0);

  OnboardingState copyWith({int? currentPage}) {
    return OnboardingState(currentPage: currentPage ?? this.currentPage);
  }
}