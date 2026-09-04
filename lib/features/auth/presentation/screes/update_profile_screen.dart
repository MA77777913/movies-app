import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_color.dart';
import 'package:movies_app/core/utils/app_text_style.dart';

import '../../../../core/utils/app_assets.dart';

import '../widgets/login_widgets/custom_button.dart';
import '../widgets/login_widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final List<String> avatars = AppAssets.avatars;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: Column(
        children: [
          SizedBox(height: 30),
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
                      backgroundImage: AssetImage(avatars[0]),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField(
              hintText: "Smahi REZGUI",
              prefixIcon: Icons.person,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomTextField(
              hintText: "22000202000020",
              prefixIcon: Icons.phone,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                "Reset Password",
                style: AppTextStyle.appBarTxtStyle.copyWith(
                  color: AppColor.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomButton(
              isNormanStyle: true,
              onPressed: () {},
              text: "Delete Account",
              backgroundColor: AppColor.red,
              textColor: AppColor.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomButton(
              isNormanStyle: true,
              onPressed: () {},
              text: "Update Data",
              backgroundColor: AppColor.yellow,
              textColor: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showAvatarBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.gray, // Dark modal container color
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
                  //final isSelected = selectedAvatarIndex == index;
                  return GestureDetector(
                    onTap: () {
                      //setModalState(() {
                        //selectedAvatarIndex = index;
                      //});
                      //setState(() {}); // Update the main screen avatar
                      //Navigator.pop(context); // Close bottom sheet
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:  Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColor.yellow,
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
      },
    );
  }
}
