import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/core/utils/service_locator.dart' as di;
import 'package:movies_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movies_app/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/update_profile/update_profile_cubit.dart';
import 'package:movies_app/features/auth/presentation/screes/forget_password_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/login_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/register_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/update_profile_screen.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/pages/main_page.dart';
import 'package:movies_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:movies_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'firebase_options.dart';

final authRepository = AuthRepositoryImpl();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
            child: const OnboardingScreen(),
          ),
          AppRoute.loginRoute: (context) => BlocProvider(
            create: (context) => LoginCubit(authRepository),
            child: const LoginScreen(),
          ),
          AppRoute.registerRoute: (context) => BlocProvider(
            create: (context) => RegisterCubit(authRepository),
            child: const RegisterScreen(),
          ),
          AppRoute.forgetPasswordRoute: (context) => BlocProvider(
            create: (context) => ResetPasswordCubit(authRepository),
            child: const ForgetPasswordScreen(),
          ),
          AppRoute.updateProfileScreen: (context) => BlocProvider(
            create: (context) => UpdateProfileCubit(authRepository),
            child: UpdateProfileScreen(),
          ),
          AppRoute.homeRoute: (context) => const MainPage(),
        },
      ),
    );
  }
}
