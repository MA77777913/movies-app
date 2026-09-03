import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_text_style.dart';
import 'package:movies_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:movies_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:movies_app/features/auth/presentation/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/widgets/register_widgets/avatar_selection.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Register",
          style: AppTextStyle.appBarTxtStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const AvatarSelection(),
                const SizedBox(height: 30),
                const CustomTextField(
                  hintText: "Name",
                  prefixIcon: Icons.badge,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                const CustomTextField(
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: () {},
                  text: "Create Account",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have Account ? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: AppColor.yellow, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const LanguageSwitcher(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
