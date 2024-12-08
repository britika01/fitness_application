import 'package:flutter/material.dart';
import 'goals_page.dart';
import 'diet_page.dart';
import 'progress_page.dart';

/// DashboardScreen widget
///
/// Author: Ritika Bhardwaj
/// This screen serves as the main dashboard of the app. It displays a navigation bar with three tabs:
/// 'Goals', 'Diet', and 'Progress'. Depending on the selected tab, the appropriate page is displayed.
/// The user's name is passed into this screen and displayed in the app bar as a personalized greeting.
class DashboardScreen extends StatefulWidget {
  final String name; // The name of the user, passed from the HomeScreen

  const DashboardScreen({super.key, required this.name});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Index of the currently selected page in the bottom navigation bar
  int _selectedIndex = 0;

  // List of pages that correspond to each tab in the bottom navigation bar
  final List<Widget> _pages = [
    const GoalsPage(), // Page to set and view goals
    const DietPage(), // Page to set and view diet plans
    const ProgressPage(), // Page to track progress
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar displays the user's name in the title
        title: Text('Welcome, ${widget.name}!'),
        centerTitle: true, // Centers the title in the app bar
      ),
      body: _pages[_selectedIndex], // Display the currently selected page
      bottomNavigationBar: BottomNavigationBar(
        // Set the current index of the navigation bar based on the selected tab
        currentIndex: _selectedIndex,
        // When a tab is tapped, update the selected index and change the displayed page
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // Define the items in the bottom navigation bar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flag), // Icon for Goals tab
            label: 'Goals', // Label for Goals tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), // Icon for Diet tab
            label: 'Diet', // Label for Diet tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart), // Icon for Progress tab
            label: 'Progress', // Label for Progress tab
          ),
        ],
      ),
    );
  }
}
