//lib/presentation/pages/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:kpopmerchapplication/presentation/pages/dashboard/explore/explore_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/home/home_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/manage/manage_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/notification/notification_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // List of pages to switch between
  final List<Widget> _pages = [
    HomeScreen(),
    const ExplorePage(),
    NotificationPage(),
    const ManagePage(),
  ];

  // Method to switch between BottomNavigationBar items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore),
            title: const Text("Explore"),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications_none),
            activeIcon: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.people_outline),
            activeIcon: const Icon(Icons.people),
            title: const Text("Manage"),
            selectedColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
