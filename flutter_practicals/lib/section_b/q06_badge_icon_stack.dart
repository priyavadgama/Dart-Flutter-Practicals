// Section B - Practical 6: Notification Badge with Stack & Positioned
// Design a badge/notification icon using Stack and Positioned, showing a count on top of an Icon.

import 'package:flutter/material.dart';

class SectionBQ06BadgeIconStack extends StatefulWidget {
  const SectionBQ06BadgeIconStack({super.key});

  @override
  State<SectionBQ06BadgeIconStack> createState() => _SectionBQ06BadgeIconStackState();
}

class _SectionBQ06BadgeIconStackState extends State<SectionBQ06BadgeIconStack> {
  int _notificationCount = 3;

  void _addNotification() {
    setState(() {
      _notificationCount++;
    });
  }

  void _clearNotifications() {
    setState(() {
      _notificationCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q6: Badge with Stack'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // Stack with Positioned for Notification Bell in AppBar
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, size: 28),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You have $_notificationCount unread alerts')),
                      );
                    },
                  ),
                  if (_notificationCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                        child: Center(
                          child: Text(
                            '$_notificationCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Large Hero Badge Demonstration using Stack & Positioned
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.indigo.shade200, width: 2),
                    ),
                    child: const Icon(Icons.mail_outline, size: 64, color: Colors.indigo),
                  ),
                  if (_notificationCount > 0)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
                          ],
                        ),
                        child: Text(
                          '$_notificationCount NEW',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 36),
              Text(
                'Unread Messages: $_notificationCount',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addNotification,
                    icon: const Icon(Icons.add_alert),
                    label: const Text('Add Alert'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: _clearNotifications,
                    icon: const Icon(Icons.mark_email_read),
                    label: const Text('Mark All Read'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
