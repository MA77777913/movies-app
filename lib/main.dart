import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/features/auth/presentation/screes/login_screen.dart';
import 'package:movies_app/features/auth/presentation/screes/register_screen.dart';

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
      initialRoute: AppRoute.loginRoute,
      routes: {
        AppRoute.loginRoute: (context) => const LoginScreen(),
        AppRoute.registerRoute: (context) => const RegisterScreen(),
      },
    );
  }
}
