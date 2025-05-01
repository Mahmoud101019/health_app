import 'package:flutter/material.dart';
import 'package:health_app/core/constants/assets.dart';
import '../../data/models/onboarding_item.dart';

class OnboardingViewModel {
  final List<OnboardingItem> _items = [
    OnboardingItem(
      image: AppAssets.onBoarding_1,
      title: 'Welcome to OptiKick',
      subtitle: 'Track your progress, set goals, and kick off your training with us!',
    ),
    OnboardingItem(
      image: AppAssets.onBoarding_2,
      title: 'Expert Analysis in Action',
      subtitle: 'Review your training and reach your goals.',
    ),
    OnboardingItem(
      image: AppAssets.onBoarding_3,
      title: 'Seamless Communication',
      subtitle: 'Connect with coaches and get personalized feedback.',
    ),
  ];

  List<OnboardingItem> get items => _items;

  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;

  void onPageChanged(int page) {
    _currentPage = page;
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void dispose() {
    _pageController.dispose();
  }
}