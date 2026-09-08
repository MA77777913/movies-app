import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_text_style.dart';
import 'package:movies_app/features/auth/presentation/cubit/update_profile/update_profile_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/update_profile/update_profile_state.dart';

import '../../../../core/utils/app_assets.dart';
import '../widgets/login_widgets/custom_button.dart';
import '../widgets/login_widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final List<String> avatars = AppAssets.avatars;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedAvatar = AppAssets.avatars.first;

  @override
  void initState() {
    super.initState();
    context.read<UpdateProfileCubit>().loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        title: Text("Pick Avatar", style: AppTextStyle.appBarTxtStyle),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          // One-time side effects: pre-fill the form the moment the profile loads
          if (state.status == UpdateProfileStatus.loaded && state.user != null) {
            _nameController.text = state.user!.name;
            _phoneController.text = state.user!.phone;
            setState(() {
              _selectedAvatar = state.user!.avatar.isNotEmpty ? state.user!.avatar : avatars.first;
            });
          }
          if (state.status == UpdateProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Something went wrong')),
            );
          }
          if (state.status == UpdateProfileStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == UpdateProfileStatus.loading || state.status == UpdateProfileStatus.initial) {
            return const Center(child: CircularProgressIndicator(color: AppColor.yellow));
          }

          final isSubmitting = state.status == UpdateProfileStatus.submitting;

          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _showAvatarBottomSheet,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Center(
                        child: SizedBox(
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.yellow, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(_selectedAvatar),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextField(controller: _nameController, hintText: "Name", prefixIcon: Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextField(controller: _phoneController, hintText: "Phone", prefixIcon: Icons.phone),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reset Password",
                        style: AppTextStyle.appBarTxtStyle.copyWith(color: AppColor.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomButton(
                      isNormanStyle: true,
                      onPressed: () {}, // Delete Account isn't part of this task's scope yet
                      text: "Delete Account",
                      backgroundColor: AppColor.red,
                      textColor: AppColor.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomButton(
                      isNormanStyle: true,
                      onPressed: () {
                        if (isSubmitting) return;
                        context.read<UpdateProfileCubit>().updateProfile(
                          name: _nameController.text.trim(),
                          phone: _phoneController.text.trim(),
                          avatar: _selectedAvatar,
                        );
                      },
                      text: "Update Data",
                      backgroundColor: AppColor.yellow,
                      textColor: AppColor.black,
                    ),
                  ),
                ],
              ),
              if (isSubmitting)
                Container(
                  color: Colors.black45,
                  child: const Center(child: CircularProgressIndicator(color: AppColor.yellow)),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showAvatarBottomSheet() {
    // to be implemented later
  }
}