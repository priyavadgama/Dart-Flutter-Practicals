// Section A - Practical 7: Drawer Navigation Menu
// Design a Drawer with at least four navigation menu items using ListTile.

import 'package:flutter/material.dart';

class SectionAQ07DrawerNavigation extends StatefulWidget {
  const SectionAQ07DrawerNavigation({super.key});

  @override
  State<SectionAQ07DrawerNavigation> createState() => _SectionAQ07DrawerNavigationState();
}

class _SectionAQ07DrawerNavigationState extends State<SectionAQ07DrawerNavigation> {
  String _selectedPage = 'Home Dashboard';
  IconData _selectedIcon = Icons.dashboard;

  final List<Map<String, dynamic>> menuItems = const [
    {'title': 'Home Dashboard', 'icon': Icons.dashboard, 'subtitle': 'Overview and analytics'},
    {'title': 'My Courses', 'icon': Icons.school, 'subtitle': 'Enrolled academic subjects'},
    {'title': 'Assignment Submissions', 'icon': Icons.assignment, 'subtitle': 'View pending and graded tasks'},
    {'title': 'College Profile', 'icon': Icons.account_circle, 'subtitle': 'Student credentials & settings'},
    {'title': 'Help & Support', 'icon': Icons.help_outline, 'subtitle': 'Contact department admin'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q7: Drawer Menu'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('VP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
              ),
              accountName: const Text('Vadgama Priya Ashokbhai', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text('15612424037@atmiyauni.edu.in (Roll: 35)'),
            ),
            ...menuItems.map((item) {
              final isSelected = _selectedPage == item['title'];
              return ListTile(
                leading: Icon(item['icon'] as IconData, color: isSelected ? Colors.deepOrange : Colors.grey.shade700),
                title: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.deepOrange : Colors.black87,
                  ),
                ),
                subtitle: Text(item['subtitle'] as String, style: const TextStyle(fontSize: 12)),
                selected: isSelected,
                selectedTileColor: Colors.deepOrange.withValues(alpha: 0.1),
                onTap: () {
                  setState(() {
                    _selectedPage = item['title'] as String;
                    _selectedIcon = item['icon'] as IconData;
                  });
                  Navigator.pop(context); // Close drawer
                },
              );
            }),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_selectedIcon, size: 72, color: Colors.deepOrange),
              const SizedBox(height: 16),
              Text(
                'Active Screen: $_selectedPage',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Swipe from left edge or tap the top-left menu icon to open the navigation Drawer with 5 ListTile items.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
