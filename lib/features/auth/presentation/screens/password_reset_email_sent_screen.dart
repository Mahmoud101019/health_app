import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app/core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';

class PasswordResetEmailSentScreen extends StatelessWidget {
  final String email;

  const PasswordResetEmailSentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textColor,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(height: screenHeight * 0.02),
                Image.asset(
                  AppAssets.forgetpassword,
                  height: screenHeight * 0.2,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Check Your Email',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'We have sent a password reset link to $email. Please check your inbox and follow the instructions.',
                  style: const TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03),
                CustomButton(
                  text: 'Back to Login',
                  onPressed: () {
                    context.go('/login');
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    context.go('/forget-password');
                  },
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
