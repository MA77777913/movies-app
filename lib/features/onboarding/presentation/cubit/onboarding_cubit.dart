import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/onboarding_model.dart';
import '../../data/models/onboarding_data.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState.initial());

  final List<OnboardingModel> pages = OnboardingData.pages;

  bool get isLastPage => state.currentPage == pages.length - 1;

  void nextPage() {
    if (state.currentPage < pages.length - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }
}