import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/core/utils/service_locator.dart' as di;
import 'package:movies_app/features/auth/presentation/screes/forget_password_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/login_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/register_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/update_profile_screen.dart';
import 'package:movies_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:movies_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:movies_app/features/movies/presentation/pages/main_page.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<MoviesCubit>()..loadMovies()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'movies app',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: AppRoute.onboardingRoute,
        routes: {
          AppRoute.onboardingRoute: (context) => BlocProvider(
                create: (context) => OnboardingCubit(),
                child: OnboardingScreen(),
              ),
          AppRoute.loginRoute: (context) => const LoginScreen(),
          AppRoute.registerRoute: (context) => const RegisterScreen(),
          AppRoute.forgetPasswordRoute: (context) => const ForgetPasswordScreen(),
          AppRoute.updateProfileScreen: (context) => UpdateProfileScreen(),
          AppRoute.homeRoute: (context) => const MainPage(),
        },
      ),
    );
  }
}
