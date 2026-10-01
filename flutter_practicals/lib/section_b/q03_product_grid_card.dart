// Section B - Practical 3: Product Listing Screen with GridView.builder
// Design a product listing screen using GridView.builder with an image, name, and price for each product card.

import 'package:flutter/material.dart';

class SectionBQ03ProductGridCard extends StatelessWidget {
  const SectionBQ03ProductGridCard({super.key});

  final List<Map<String, dynamic>> products = const [
    {'name': 'Apple MacBook Air M3', 'price': 114900, 'category': 'Laptops', 'icon': Icons.laptop_mac, 'color': Colors.blueGrey},
    {'name': 'iPhone 16 Pro Max', 'price': 134900, 'category': 'Smartphones', 'icon': Icons.phone_iphone, 'color': Colors.indigo},
    {'name': 'Sony WH-1000XM5', 'price': 29990, 'category': 'Audio', 'icon': Icons.headphones, 'color': Colors.brown},
    {'name': 'Apple Watch Series 10', 'price': 46900, 'category': 'Wearables', 'icon': Icons.watch, 'color': Colors.teal},
    {'name': 'iPad Pro 11-inch M4', 'price': 99900, 'category': 'Tablets', 'icon': Icons.tablet_mac, 'color': Colors.deepPurple},
    {'name': 'Logitech MX Master 3S', 'price': 8995, 'category': 'Accessories', 'icon': Icons.mouse, 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q3: Product GridView.builder'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final p = products[index];
            final Color color = p['color'] as Color;

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image Representation Area
                  Container(
                    height: 110,
                    width: double.infinity,
                    color: color.withValues(alpha: 0.15),
                    child: Center(
                      child: Icon(p['icon'] as IconData, size: 54, color: color),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['category'] as String,
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            p['name'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${p['price']}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green),
                              ),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Added ${p['name']} to cart')),
                                  );
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add_shopping_cart, size: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
