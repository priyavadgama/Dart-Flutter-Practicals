// Section A - Practical 5: GridView.count with 6 Coloured Boxes
// Build a GridView.count that displays 6 coloured boxes with 2 items per row.

import 'package:flutter/material.dart';

class SectionAQ05GridViewColoredBoxes extends StatelessWidget {
  const SectionAQ05GridViewColoredBoxes({super.key});

  final List<Map<String, dynamic>> boxData = const [
    {'name': 'Ocean Blue', 'color': Color(0xFF1E88E5), 'code': '#1E88E5'},
    {'name': 'Emerald Green', 'color': Color(0xFF43A047), 'code': '#43A047'},
    {'name': 'Crimson Red', 'color': Color(0xFFE53935), 'code': '#E53935'},
    {'name': 'Amber Gold', 'color': Color(0xFFFFB300), 'code': '#FFB300'},
    {'name': 'Royal Purple', 'color': Color(0xFF8E24AA), 'code': '#8E24AA'},
    {'name': 'Sunset Orange', 'color': Color(0xFFFB8C00), 'code': '#FB8C00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q5: GridView.count Boxes'),
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '6 Coloured Boxes (2 Items Per Row)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Implemented using GridView.count with crossAxisCount: 2',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
                children: List.generate(boxData.length, (index) {
                  final item = boxData[index];
                  final Color color = item['color'] as Color;
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected: ${item['name']} (${item['code']})')),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              'Box ${index + 1}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item['code'] as String,
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
