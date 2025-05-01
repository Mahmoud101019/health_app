import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/forget_password_screen.dart';
import 'features/auth/presentation/screens/password_reset_email_sent_screen.dart';
import 'features/auth/presentation/screens/enter_new_password_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/messages/presentation/screens/messages_screen.dart';
import 'features/messages/presentation/screens/chat_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forget-password',
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: '/password-reset-email-sent',
      builder: (context, state) {
        final email = state.extra as String? ?? 'example@email.com';
        return PasswordResetEmailSentScreen(email: email);
      },
    ),
    GoRoute(
      path: '/enter-new-password',
      builder: (context, state) => const EnterNewPasswordScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Notifications Screen')),
      ),
    ),
    GoRoute(
      path: '/messages',
      builder: (context, state) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final username = state.extra as String? ?? 'User';
        return ChatScreen(username: username);
      },
    ),
  ],
);