// Section A - Practical 10: Reusable Custom SectionTitle Widget
// Create a custom widget called 'SectionTitle' that displays styled heading text,
// and reuse it on two different screens.

import 'package:flutter/material.dart';

// Reusable Custom Widget: SectionTitle
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color accentColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.accentColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: accentColor, size: 24),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accentColor.shade900 ?? accentColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Extension on Color to provide shade900 safely
extension ColorShade on Color {
  Color? get shade900 => this is MaterialColor ? (this as MaterialColor)[900] : this;
}

// Master demo screen demonstrating reuse across Screen 1 and Screen 2
class SectionAQ10CustomSectionTitle extends StatefulWidget {
  const SectionAQ10CustomSectionTitle({super.key});

  @override
  State<SectionAQ10CustomSectionTitle> createState() => _SectionAQ10CustomSectionTitleState();
}

class _SectionAQ10CustomSectionTitleState extends State<SectionAQ10CustomSectionTitle> {
  int _activeScreen = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q10: Reusable SectionTitle'),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _activeScreen = 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeScreen == 1 ? Colors.teal : Colors.grey.shade300,
                      foregroundColor: _activeScreen == 1 ? Colors.white : Colors.black87,
                    ),
                    child: const Text('View Screen 1 (Academics)'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _activeScreen = 2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeScreen == 2 ? Colors.teal : Colors.grey.shade300,
                      foregroundColor: _activeScreen == 2 ? Colors.white : Colors.black87,
                    ),
                    child: const Text('View Screen 2 (Settings)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_activeScreen == 1) _buildScreenOne() else _buildScreenTwo(),
          ],
        ),
      ),
    );
  }

  // Screen 1: Academic Portal using SectionTitle
  Widget _buildScreenOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Student Profile',
          subtitle: 'Enrolled under Atmiya University, Rajkot',
          icon: Icons.school,
          accentColor: Colors.teal,
        ),
        const Card(
          child: ListTile(
            title: Text('Vadgama Priya Ashokbhai (Roll: 35)'),
            subtitle: Text('B.Tech B.C.A. (C.S. & I.T.) - 5th Semester'),
          ),
        ),
        const SizedBox(height: 12),
        const SectionTitle(
          title: 'Current Term Courses',
          subtitle: '4 Core Subjects & 1 Elective',
          icon: Icons.book,
          accentColor: Colors.indigo,
        ),
        const Card(
          child: Column(
            children: [
              ListTile(title: Text('Mobile Application Development (Flutter)')),
              Divider(height: 1),
              ListTile(title: Text('Cloud Computing & Virtualization')),
            ],
          ),
        ),
      ],
    );
  }

  // Screen 2: System Settings using the same SectionTitle
  Widget _buildScreenTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Account Security',
          subtitle: 'Passwords, two-factor auth & biometric access',
          icon: Icons.security,
          accentColor: Colors.deepOrange,
        ),
        const Card(
          child: ListTile(
            title: Text('Two-Factor Authentication'),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
        ),
        const SizedBox(height: 12),
        const SectionTitle(
          title: 'Storage & Data Saver',
          subtitle: 'Cache management and network usage limits',
          icon: Icons.storage,
          accentColor: Colors.purple,
        ),
        const Card(
          child: ListTile(
            title: Text('Offline Cache Size'),
            trailing: Text('14.2 MB', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
