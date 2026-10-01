import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 5:
/// Create a fully responsive navigation shell: a Drawer for mobile width and
/// a permanent side NavigationRail-style Column for desktop width, switching
/// automatically using LayoutBuilder.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q05ResponsiveNavShellScreen(),
  ));
}

class Q05ResponsiveNavShellScreen extends StatefulWidget {
  const Q05ResponsiveNavShellScreen({super.key});

  @override
  State<Q05ResponsiveNavShellScreen> createState() => _Q05ResponsiveNavShellScreenState();
}

class _Q05ResponsiveNavShellScreenState extends State<Q05ResponsiveNavShellScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _destinations = [
    {'title': 'Dashboard', 'icon': Icons.dashboard},
    {'title': 'Analytics', 'icon': Icons.analytics},
    {'title': 'Courses', 'icon': Icons.school},
    {'title': 'Assignments', 'icon': Icons.assignment},
    {'title': 'Settings', 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width >= 800 dp -> Desktop / Wide view
        final isDesktop = constraints.maxWidth >= 800;

        return Scaffold(
          appBar: AppBar(
            title: Text('Navigation Shell (${isDesktop ? "Desktop Mode" : "Mobile Mode"})'),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            // Automatically shows hamburger drawer icon on mobile, hides on desktop
            automaticallyImplyLeading: !isDesktop,
          ),
          // Drawer active ONLY in mobile width
          drawer: isDesktop ? null : _buildMobileDrawer(),
          body: Row(
            children: [
              // Permanent side NavigationRail / Column ONLY in desktop width
              if (isDesktop) _buildDesktopSideRail(),
              // Main content body
              Expanded(
                child: _buildMainContent(isDesktop),
              ),
            ],
          ),
        );
      },
    );
  }

  // 1. Mobile Drawer
  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            accountName: const Text('Vadgama Priya Ashokbhai', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: const Text('smit.kanojiya@student.edu'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('VP', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo.shade800)),
            ),
          ),
          ...List.generate(_destinations.length, (index) {
            final dest = _destinations[index];
            final isSelected = _selectedIndex == index;
            return ListTile(
              leading: Icon(dest['icon'] as IconData, color: isSelected ? Colors.indigo : Colors.grey),
              title: Text(
                dest['title'] as String,
                style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.indigo : Colors.black87),
              ),
              selected: isSelected,
              onTap: () {
                setState(() => _selectedIndex = index);
                Navigator.pop(context); // Close drawer
              },
            );
          }),
        ],
      ),
    );
  }

  // 2. Permanent Desktop Side Column
  Widget _buildDesktopSideRail() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: Colors.indigo.shade50,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: const Text('VP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vadgama Priya Ashokbhai', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Desktop Shell', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _destinations.length,
              itemBuilder: (context, index) {
                final dest = _destinations[index];
                final isSelected = _selectedIndex == index;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.indigo.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(dest['icon'] as IconData, color: isSelected ? Colors.indigo : Colors.grey.shade700),
                    title: Text(
                      dest['title'] as String,
                      style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.indigo : Colors.black87),
                    ),
                    onTap: () => setState(() => _selectedIndex = index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 3. Main Content
  Widget _buildMainContent(bool isDesktop) {
    final activeDestination = _destinations[_selectedIndex]['title'] as String;
    final activeIcon = _destinations[_selectedIndex]['icon'] as IconData;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.indigo.shade50,
              child: Icon(activeIcon, size: 48, color: Colors.indigo),
            ),
            const SizedBox(height: 20),
            Text(
              'Active Section: $activeDestination',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              isDesktop
                ? 'Desktop Mode: Permanent side Navigation Column is visible.'
                : 'Mobile Mode: Tap the top-left hamburger icon to slide out the Drawer.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
