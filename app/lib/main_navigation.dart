import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // This variable tracks which tab is currently selected
  int _currentIndex = 0;
  
  // List of pages - each index corresponds to a bottom nav item
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body shows the current page based on _currentIndex
      body: _pages[_currentIndex],
      
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        // Current selected tab
        currentIndex: _currentIndex,
        
        // What happens when user taps a tab
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        
        // The navigation items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
} 