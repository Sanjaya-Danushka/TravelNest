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
      backgroundColor: Color(0xFFFAFAFA),
      body: _pages[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(color: Colors.transparent),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 30,
                  offset: Offset(0, -10),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildModernNavItem(0, Icons.home_outlined, 'Home'),
                ),
                Expanded(
                  child: _buildModernNavItem(
                    1,
                    Icons.explore_outlined,
                    'Explore',
                  ),
                ),
                Expanded(
                  child: _buildModernNavItem(
                    2,
                    Icons.favorite_border,
                    'Favorites',
                  ),
                ),
                Expanded(
                  child: _buildModernNavItem(
                    3,
                    Icons.person_outline,
                    'Profile',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        height: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Modern icon container
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(colors: [Colors.white, Colors.white]),
                borderRadius: BorderRadius.circular(22.5),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Color(0xFF667EEA).withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Color(0xFF6B7280),
                size: 22,
              ),
            ),
            SizedBox(height: 6),
            // Modern text label
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Color(0xFF667EEA) : Color(0xFF9CA3AF),
                fontFamily: 'SF Pro Display',
                letterSpacing: isSelected ? 0.3 : 0.1,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
