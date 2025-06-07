import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/bookmark/bookmark_screen.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/profile/profile_screen.dart';
import 'package:news_app/features/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreenIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        currentIndex: _currentScreenIndex,
        items: [
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/images/home.svg', 0), label: 'Home'),
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/images/search.svg', 1), label: 'Search'),
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/images/bookMark.svg', 2), label: 'Bookmark'),
          BottomNavigationBarItem(icon: _buildSvgPicture('assets/images/profile.svg', 3), label: 'Profile'),
        ],
      ),
      body: _screens[_currentScreenIndex],
    );
  }
  SvgPicture _buildSvgPicture(String path, int index) => SvgPicture.asset(
    path,
    colorFilter: ColorFilter.mode(
      _currentScreenIndex == index ? Color(0xFFC53030) : Color(0xFF363636),
      BlendMode.srcIn,
    ),
  );

}
