// Section B - Practical 4: Custom ProfileCard Widget
// Build a custom 'ProfileCard' widget accepting name, role, image URL and an onTap callback
// as constructor parameters, and use it three times with different data.

import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String initials;
  final Color avatarColor;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    required this.avatarColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: avatarColor,
                child: Text(
                  initials,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionBQ04ProfileCardWidget extends StatelessWidget {
  const SectionBQ04ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q4: Custom ProfileCard'),
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Team Directory (3 Reusable Profile Cards)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ProfileCard instantiated 3 times with custom constructor arguments & callbacks.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Instance 1: Vadgama Priya Ashokbhai
            ProfileCard(
              name: 'Vadgama Priya Ashokbhai (Roll: 35)',
              role: 'Lead Flutter Engineer & B.C.A. (C.S. & I.T.) Student',
              initials: 'VP',
              avatarColor: Colors.deepPurple,
              onTap: () {
                _showDetails(context, 'Vadgama Priya Ashokbhai', 'Lead Flutter Engineer', '15612424037@atmiyauni.edu.in');
              },
            ),

            // Instance 2: Prof. Rajesh Mehta
            ProfileCard(
              name: 'Prof. Rajesh Mehta',
              role: 'Head of Department - B.C.A. (C.S. & I.T.)',
              initials: 'RM',
              avatarColor: Colors.indigo,
              onTap: () {
                _showDetails(context, 'Prof. Rajesh Mehta', 'HOD Computer Dept', 'rajesh.mehta@scet.ac.in');
              },
            ),

            // Instance 3: Ananya Patel
            ProfileCard(
              name: 'Ananya Patel',
              role: 'UI/UX Designer & Product Researcher',
              initials: 'AP',
              avatarColor: Colors.teal,
              onTap: () {
                _showDetails(context, 'Ananya Patel', 'UI/UX Specialist', 'ananya.p@college.edu');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, String name, String role, String email) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(role, style: const TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email, size: 16, color: Colors.purple),
                const SizedBox(width: 8),
                Text(email, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
