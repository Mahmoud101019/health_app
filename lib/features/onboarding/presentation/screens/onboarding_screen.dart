import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../view_models/onboarding_view_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = OnboardingViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _viewModel.pageController,
              onPageChanged: (int page) {
                setState(() {
                  _viewModel.onPageChanged(page);
                });
              },
              itemCount: _viewModel.items.length,
              itemBuilder: (context, index) {
                final item = _viewModel.items[index];
                return _buildPage(
                  image: item.image,
                  title: item.title,
                  subtitle: item.subtitle,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  context: context,
                );
              },
            ),
            if (_viewModel.currentPage != _viewModel.items.length - 1) // Skip button for first two pages
              Positioned(
                top: screenHeight * 0.05,
                right: screenWidth * 0.06,
                child: TextButton(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _viewModel.items.length,
                      (index) => _buildDot(index, _viewModel.currentPage),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  if (_viewModel.currentPage != _viewModel.items.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: CustomButton(
                        text: 'Next',
                        onPressed: () {
                          _viewModel.nextPage();
                        },
                      ),
                    ),
                  if (_viewModel.currentPage == _viewModel.items.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: CustomButton(
                        text: 'Get Started',
                        onPressed: () {
                          context.go('/dashboard');
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String subtitle,
    required double screenWidth,
    required double screenHeight,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: screenWidth * 0.6,
          height: screenHeight * 0.4,
        ),
        SizedBox(height: screenHeight * 0.03),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenHeight * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index, int currentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index
            ? AppColors.textColor
            : AppColors.secondaryTextColor,
      ),
    );
  }
}