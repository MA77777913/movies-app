import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: AppColor.gray,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 0),
          _buildNavItem(Icons.search, 1),
          _buildNavItem(Icons.explore, 2),
          _buildNavItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppColor.yellow : Colors.white,
        size: 30,
      ),
      onPressed: () => onTap(index),
    );
  }
}
