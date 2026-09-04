import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/features/auth/presentation/widgets/login_widgets/custom_button.dart';
import 'package:movies_app/features/auth/presentation/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/widgets/social_login_button.dart';

import '../widgets/login_widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    AppAssets.loginImage,
                    height: 180,
                  ),
                  const SizedBox(height: 40),
                  const CustomTextField(
                    hintText: "Email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
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
                        style: TextStyle(
                            color: AppColor.yellow, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {},
                    text: "Login",
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have Account ? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.registerRoute);
                        },
                        child: const Text(
                          "Create One",
                          style: TextStyle(
                              color: AppColor.yellow, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 92.96,
                        child: Divider(
                          color: AppColor.yellow,
                          thickness: 1.12,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: AppColor.yellow),
                      ),
                      SizedBox(
                        width: 92.96,
                        child: Divider(
                          color: AppColor.yellow,
                          thickness: 1.12,
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SocialLoginButton(
                    onPressed: () {},
                    label: "Login With Google",
                    icon: Icons.g_mobiledata,
                  ),
                  const SizedBox(height: 40),
                  const LanguageSwitcher(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
