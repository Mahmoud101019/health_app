import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundGradientStart = Color(0xFF1A3C34);
  static const Color backgroundGradientEnd = Color(0xFF2A5C4A);
  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundGradientStart, backgroundGradientEnd],
  );
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFFB0BEC5);
  static const Color buttonBackgroundColor = Colors.white;
  static const Color buttonTextColor = Color(0xFF1A3C34);

  static const Color buttonColor = Color(0xFF2A5C4A);
  static const Color optimalColor = Color(0xFF4CAF50);
  static const Color atRiskColor = Color(0xFFFFC107);
  static const Color underperformingColor = Color(0xFFF44336);
  static const Color recoveringColor = Color(0xFF2196F3);
}
