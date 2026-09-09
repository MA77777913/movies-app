import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/login/login_state.dart';
import 'package:movies_app/features/auth/presentation/widgets/login_widgets/custom_button.dart';
import 'package:movies_app/features/auth/presentation/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/widgets/social_login_button.dart';

import '../widgets/login_widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
              );
            }
            if (state.status == LoginStatus.success) {
              Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
            }
          },
          builder: (context, state) {
            final isLoading = state.status == LoginStatus.loading;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(AppAssets.loginImage, height: 180),
                          const SizedBox(height: 40),
                          CustomTextField(
                            controller: _emailController,
                            hintText: "Email",
                            prefixIcon: Icons.email,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: "Password",
                            prefixIcon: Icons.lock,
                            isPassword: true,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoute.forgetPasswordRoute);
                              },
                              child: const Text(
                                "Forget Password ?",
                                style: TextStyle(color: AppColor.yellow, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            onPressed: () {
                              if (isLoading) return;
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill in both fields')),
                                );
                                return;
                              }
                              context.read<LoginCubit>().login(email: email, password: password);
                            },
                            text: "Login",
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't Have Account ? ", style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, AppRoute.registerRoute),
                                child: const Text(
                                  "Create One",
                                  style: TextStyle(color: AppColor.yellow, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 92.96, child: Divider(color: AppColor.yellow, thickness: 1.12, endIndent: 10)),
                              Text("OR", style: TextStyle(color: AppColor.yellow)),
                              SizedBox(width: 92.96, child: Divider(color: AppColor.yellow, thickness: 1.12, indent: 10)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SocialLoginButton(onPressed: () {}, label: "Login With Google", icon: Icons.g_mobiledata),
                          const SizedBox(height: 40),
                          const LanguageSwitcher(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  Container(
                    color: Colors.black45,
                    child: const Center(child: CircularProgressIndicator(color: AppColor.yellow)),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}