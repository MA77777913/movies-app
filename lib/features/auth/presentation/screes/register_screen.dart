import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/register/register_state.dart';
import 'package:movies_app/features/auth/presentation/widgets/language_switcher.dart';
import 'package:movies_app/features/auth/presentation/widgets/register_widgets/avatar_selection.dart';

import '../widgets/login_widgets/custom_button.dart';
import '../widgets/login_widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  // AvatarSelection isn't wired to a callback yet — using the first avatar
  // as a placeholder until that widget can report the chosen one back up.
  String _selectedAvatar = AppAssets.avatars.first;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
        title: const Text("Register", style: TextStyle(color: AppColor.yellow)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Registration failed')),
              );
            }
            if (state.status == RegisterStatus.success) {
              Navigator.pop(context); // back to Login
            }
          },
          builder: (context, state) {
            final isLoading = state.status == RegisterStatus.loading;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        const AvatarSelection(),
                        const SizedBox(height: 30),
                        CustomTextField(controller: _nameController, hintText: "Name", prefixIcon: Icons.badge),
                        const SizedBox(height: 20),
                        CustomTextField(controller: _emailController, hintText: "Email", prefixIcon: Icons.email),
                        const SizedBox(height: 20),
                        CustomTextField(controller: _passwordController, hintText: "Password", prefixIcon: Icons.lock, isPassword: true),
                        const SizedBox(height: 20),
                        CustomTextField(controller: _confirmPasswordController, hintText: "Confirm Password", prefixIcon: Icons.lock, isPassword: true),
                        const SizedBox(height: 20),
                        CustomTextField(controller: _phoneController, hintText: "Phone Number", prefixIcon: Icons.phone),
                        const SizedBox(height: 30),
                        CustomButton(
                          onPressed: () {
                            if (isLoading) return;
                            final name = _nameController.text.trim();
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            final confirmPassword = _confirmPasswordController.text.trim();
                            final phone = _phoneController.text.trim();

                            if ([name, email, password, confirmPassword, phone].any((f) => f.isEmpty)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill in all fields')),
                              );
                              return;
                            }
                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Passwords do not match')),
                              );
                              return;
                            }
                            context.read<RegisterCubit>().register(
                              email: email,
                              password: password,
                              name: name,
                              phone: phone,
                              avatar: _selectedAvatar,
                            );
                          },
                          text: "Create Account",
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already Have Account ? ", style: TextStyle(color: Colors.white)),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text("Login", style: TextStyle(color: AppColor.yellow, fontWeight: FontWeight.bold)),
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