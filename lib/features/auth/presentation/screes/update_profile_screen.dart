import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_route.dart';
import 'package:movies_app/core/utils/app_text_style.dart';
import 'package:movies_app/features/auth/presentation/cubit/update_profile/update_profile_cubit.dart';
import 'package:movies_app/features/auth/presentation/cubit/update_profile/update_profile_state.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Pick Avatar",
          style: AppTextStyle.appBarTxtStyle.copyWith(
            color: AppColor.yellow,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.yellow),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state.status == UpdateProfileStatus.loaded && state.user != null) {
            _nameController.text = state.user!.name;
            _phoneController.text = state.user!.phone;
            setState(() {
              _selectedAvatar = state.user!.avatar.isNotEmpty
                  ? state.user!.avatar
                  : avatars.first;
            });
          }
          if (state.status == UpdateProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Something went wrong')),
            );
          }
          if (state.status == UpdateProfileStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.status == UpdateProfileStatus.loading ||
              state.status == UpdateProfileStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.yellow),
            );
          }

          final isSubmitting = state.status == UpdateProfileStatus.submitting;

          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _showAvatarBottomSheet,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(_selectedAvatar),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        controller: _nameController,
                        hintText: "John Safwat",
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: "01200000000",
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.forgetPasswordRoute,
                            );
                          },
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        isNormanStyle: true,
                        onPressed: () {},
                        text: "Delete Account",
                        backgroundColor: AppColor.red,
                        textColor: AppColor.white,
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                if (isSubmitting)
                  Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColor.yellow),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAvatarBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.gray,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final isSelected = _selectedAvatar == avatars[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColor.yellow : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatars[index]),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
