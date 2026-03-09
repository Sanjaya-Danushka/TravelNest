import 'package:flutter/material.dart';
import 'package:travel/pages/home.dart';
import 'package:travel/pages/explore.dart';
import 'package:travel/pages/favorites.dart';
import 'package:travel/pages/profile.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [Home(), Explore(), Favorites(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 30,
              offset: Offset(0, -5),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro Display',
              letterSpacing: -0.2,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'SF Pro Display',
              letterSpacing: -0.2,
            ),
            selectedItemColor: Color(0xFF007AFF),
            unselectedItemColor: Color(0xFF8E8E93),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.home_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.home, size: 24),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.explore_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.explore, size: 24),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.favorite_border, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.favorite, size: 24),
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.person_outline, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Icon(Icons.person, size: 24),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
