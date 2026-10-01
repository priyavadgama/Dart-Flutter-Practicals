import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 2:
/// Create a reusable custom widget library containing at least three custom
/// widgets (e.g. CustomButton, CustomCard, CustomAppBar) and combine them into
/// one complete demo screen.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q02CustomWidgetLibraryDemoScreen(),
  ));
}

// ================= 1. REUSABLE CUSTOM WIDGET: CustomAppBar =================
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined, color: Colors.white),
            onPressed: onNotificationTap,
          ),
        ],
      ),
    );
  }
}

// ================= 2. REUSABLE CUSTOM WIDGET: CustomCard =================
class CustomCard extends StatelessWidget {
  final String header;
  final String description;
  final IconData icon;
  final Color accentColor;
  final Widget? trailing;

  const CustomCard({
    super.key,
    required this.header,
    required this.description,
    required this.icon,
    this.accentColor = Colors.indigo,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(color: accentColor.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(header, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

// ================= 3. REUSABLE CUSTOM WIDGET: CustomButton =================
class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor = Colors.indigo,
    this.textColor = Colors.white,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
    );
  }
}

// ================= COMPLETE DEMO SCREEN =================
class Q02CustomWidgetLibraryDemoScreen extends StatelessWidget {
  const Q02CustomWidgetLibraryDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Custom Widget Library',
        subtitle: 'CustomAppBar + CustomCard + CustomButton Demo',
        onNotificationTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CustomAppBar notification icon pressed!')),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Showcase of Reusable Components',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Each widget below is built cleanly as an independent reusable component with encapsulated parameters and styling.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            CustomCard(
              header: 'Mobile App Architecture',
              description: 'State management and clean code principles',
              icon: Icons.architecture,
              accentColor: Colors.deepPurple,
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
            CustomCard(
              header: 'High Performance UI',
              description: '60+ FPS smooth rendering with custom layout builders',
              icon: Icons.speed,
              accentColor: Colors.teal,
              trailing: const Icon(Icons.check_circle, color: Colors.teal),
            ),
            CustomCard(
              header: 'Cross-Platform Engine',
              description: 'Deploy seamlessly to iOS, Android, macOS, and Web',
              icon: Icons.devices,
              accentColor: Colors.amber.shade800,
              trailing: const Icon(Icons.star, color: Colors.amber),
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Primary Custom Action',
              icon: Icons.rocket_launch,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('CustomButton (Primary) was tapped!')),
                );
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              label: 'Secondary Success Action',
              icon: Icons.check,
              backgroundColor: Colors.teal,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('CustomButton (Secondary) was tapped!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
