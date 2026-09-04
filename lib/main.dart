import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/features/auth/presentation/screes/forget_password_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/login_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/register_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/update_profile_screen.dart';
import 'package:movies_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:movies_app/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'movies app',
      initialRoute: AppRoute.updateProfileScreen,
      routes: {
        AppRoute.onboardingRoute: (context) => BlocProvider(
              create: (context) => OnboardingCubit(),
              child: const OnboardingScreen(),
            ),
        AppRoute.loginRoute: (context) => const LoginScreen(),
        AppRoute.registerRoute: (context) => const RegisterScreen(),
        AppRoute.forgetPasswordRoute: (context) => const ForgetPasswordScreen(),
        AppRoute.updateProfileScreen: (context) =>  UpdateProfileScreen(),
      },
    );
  }
}
