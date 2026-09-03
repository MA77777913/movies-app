import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/features/auth/presentation/widgets/login_widgets/custom_button.dart';
import 'package:movies_app/features/auth/presentation/widgets/login_widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
        title: const Text(
          'Forget Password',
          style: TextStyle(
            color: AppColor.yellow,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                AppAssets.forgotPasswordImage,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              const CustomTextField(
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  // TODO: Implement verify email logic
                },
                text: 'Verify Email',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
