import 'package:flutter/material.dart';
import 'home_page.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    ),
    const Center(
      child: Text(
        'Browse Screen',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    ),
    const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
