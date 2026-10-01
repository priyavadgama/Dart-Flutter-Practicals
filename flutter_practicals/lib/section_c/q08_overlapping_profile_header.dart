import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 8:
/// Create a custom layout using Stack and Positioned to build a profile header
/// where a circular avatar overlaps the bottom edge of a banner image,
/// similar to popular social media app headers.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q08OverlappingProfileHeaderScreen(),
  ));
}

class Q08OverlappingProfileHeaderScreen extends StatelessWidget {
  const Q08OverlappingProfileHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double bannerHeight = 180.0;
    const double avatarRadius = 50.0; // Avatar diameter = 100.0

    return Scaffold(
      appBar: AppBar(
        title: const Text('Section C Q8: Overlapping Profile Header'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= STACK & POSITIONED OVERLAPPING HEADER =================
            Stack(
              clipBehavior: Clip.none, // Allows avatar to overflow bottom of banner
              children: [
                // 1. Cover Banner Image / Gradient
                Container(
                  height: bannerHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade800, Colors.deepPurple.shade600, Colors.pink.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white70),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                // 2. Overlapping Circular Avatar
                Positioned(
                  top: bannerHeight - avatarRadius, // Centered directly on the bottom banner border
                  left: 24.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.0),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // Spacing to account for the bottom half of the overlapping avatar
            const SizedBox(height: avatarRadius + 12),
            // Profile Information Body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vadgama Priya Ashokbhai',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '@priyavadgama • Roll No: 35',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Full-stack Mobile Engineer & AI Enthusiast. Exploring cross-platform architecture, reactive systems with Flutter, and Deep Learning applications.',
                    style: TextStyle(height: 1.4, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('Mumbai, India', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 16),
                      Icon(Icons.calendar_month_outlined, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('Joined 2024', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statItem('Practicals', '52 Done'),
                      _statItem('Repositories', '18 Active'),
                      _statItem('Contributions', '1,240+'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
