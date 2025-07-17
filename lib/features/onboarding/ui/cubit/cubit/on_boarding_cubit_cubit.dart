import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'on_boarding_cubit_state.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  final PageController pageController = PageController();

  /// Update current page index
  void changePage(int index) {
    emit(index);
  }

  /// Move to the next page if available
  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Move to the previous page
  void previousPage() {
    if (state > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
