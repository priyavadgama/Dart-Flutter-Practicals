// Section A - Practical 4: ListView.builder with Fruits
// Create a ListView.builder that displays a list of at least 10 fruit names.

import 'package:flutter/material.dart';

class SectionAQ04ListViewFruits extends StatelessWidget {
  const SectionAQ04ListViewFruits({super.key});

  final List<Map<String, dynamic>> fruits = const [
    {'name': 'Apple', 'color': Colors.red, 'icon': Icons.apple, 'calories': '52 kcal'},
    {'name': 'Banana', 'color': Colors.amber, 'icon': Icons.eco, 'calories': '89 kcal'},
    {'name': 'Orange', 'color': Colors.orange, 'icon': Icons.circle, 'calories': '47 kcal'},
    {'name': 'Mango', 'color': Colors.amberAccent, 'icon': Icons.star, 'calories': '60 kcal'},
    {'name': 'Strawberry', 'color': Colors.pink, 'icon': Icons.favorite, 'calories': '32 kcal'},
    {'name': 'Grapes', 'color': Colors.purple, 'icon': Icons.bubble_chart, 'calories': '67 kcal'},
    {'name': 'Pineapple', 'color': Colors.yellow, 'icon': Icons.flare, 'calories': '50 kcal'},
    {'name': 'Watermelon', 'color': Colors.green, 'icon': Icons.pie_chart, 'calories': '30 kcal'},
    {'name': 'Pomegranate', 'color': Colors.redAccent, 'icon': Icons.grain, 'calories': '83 kcal'},
    {'name': 'Kiwi', 'color': Colors.lightGreen, 'icon': Icons.spa, 'calories': '61 kcal'},
    {'name': 'Papaya', 'color': Colors.deepOrange, 'icon': Icons.wb_sunny, 'calories': '43 kcal'},
    {'name': 'Blueberry', 'color': Colors.indigo, 'icon': Icons.brightness_1, 'calories': '57 kcal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q4: ListView Fruits'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (fruit['color'] as Color).withValues(alpha: 0.2),
                child: Icon(fruit['icon'] as IconData, color: fruit['color'] as Color),
              ),
              title: Text(
                fruit['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text('Nutrition per 100g: ${fruit['calories']}'),
              trailing: Chip(
                label: Text('#${index + 1}'),
                backgroundColor: Colors.grey.shade200,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected fruit: ${fruit['name']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
