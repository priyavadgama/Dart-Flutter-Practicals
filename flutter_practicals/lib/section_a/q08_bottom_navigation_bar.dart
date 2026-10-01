// Section A - Practical 8: BottomNavigationBar with Three Tabs
// Build a BottomNavigationBar with three tabs: Home, Search, and Profile.

import 'package:flutter/material.dart';

class SectionAQ08BottomNavigationBar extends StatefulWidget {
  const SectionAQ08BottomNavigationBar({super.key});

  @override
  State<SectionAQ08BottomNavigationBar> createState() => _SectionAQ08BottomNavigationBarState();
}

class _SectionAQ08BottomNavigationBarState extends State<SectionAQ08BottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _HomeScreenTab(),
    _SearchScreenTab(),
    _ProfileScreenTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q8: Bottom Navigation Bar'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeScreenTab extends StatelessWidget {
  const _HomeScreenTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 72, color: Colors.blueAccent),
          SizedBox(height: 16),
          Text('Home Screen Tab', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Welcome to the application dashboard.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _SearchScreenTab extends StatelessWidget {
  const _SearchScreenTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 72, color: Colors.blueAccent),
            const SizedBox(height: 16),
            const Text('Search Screen Tab', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search courses, subjects, assignments...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileScreenTab extends StatelessWidget {
  const _ProfileScreenTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 44,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Vadgama Priya Ashokbhai', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('Roll No: 35 | B.C.A. (C.S. & I.T.)', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
