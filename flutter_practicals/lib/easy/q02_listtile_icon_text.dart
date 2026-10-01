import 'package:flutter/material.dart';

/// Easy Level - Practical 2:
/// In ListView.builder, create a ListTile with an Icon and text for each item.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q02ListTileIconTextScreen(),
  ));
}

class PracticalItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const PracticalItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class Q02ListTileIconTextScreen extends StatelessWidget {
  const Q02ListTileIconTextScreen({super.key});

  final List<PracticalItem> items = const [
    PracticalItem(title: 'Camera', subtitle: 'Capture photos and videos', icon: Icons.camera_alt),
    PracticalItem(title: 'Music Player', subtitle: 'Listen to favorite tracks', icon: Icons.music_note),
    PracticalItem(title: 'Navigation', subtitle: 'Real-time GPS direction', icon: Icons.map),
    PracticalItem(title: 'Cloud Storage', subtitle: 'Sync files securely', icon: Icons.cloud),
    PracticalItem(title: 'Settings', subtitle: 'Configure app preferences', icon: Icons.settings),
    PracticalItem(title: 'Security', subtitle: 'Biometric & passkey protection', icon: Icons.security),
    PracticalItem(title: 'Calendar', subtitle: 'Schedule exams and events', icon: Icons.calendar_month),
    PracticalItem(title: 'Notifications', subtitle: 'Alerts and updates', icon: Icons.notifications),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Q2: ListTile with Icon & Text'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade100,
                child: Icon(item.icon, color: Colors.teal.shade800),
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${item.title}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
