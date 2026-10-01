// Section A - Practical 6: Card Widget with Image, Title & Description
// Create a Card widget containing an image, a title, and a short description.

import 'package:flutter/material.dart';

class SectionAQ06CardWidgetImageDesc extends StatelessWidget {
  const SectionAQ06CardWidgetImageDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q6: Card with Image & Text'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // The Card Widget as required by practical specification
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image representation container (styled banner)
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.flutter_dash, size: 90, color: Colors.white70),
                        Positioned(
                          bottom: 12,
                          right: 16,
                          child: Chip(
                            label: Text('Featured Project', style: TextStyle(color: Colors.white, fontSize: 11)),
                            backgroundColor: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mobile Application Development with Flutter',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Flutter is Google’s open-source UI software development kit. '
                          'It enables developers to build natively compiled, multi-platform applications '
                          'for mobile (iOS & Android), web, and desktop from a single, unified codebase.',
                          style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.person, size: 16, color: Colors.indigo),
                                SizedBox(width: 6),
                                Text('Vadgama Priya Ashokbhai (Roll: 35)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Card action button clicked!')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: const Icon(Icons.explore, size: 16),
                              label: const Text('Read More'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
