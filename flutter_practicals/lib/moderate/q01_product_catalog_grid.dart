import 'package:flutter/material.dart';

/// Moderate Level - Practical 1:
/// Create a Product Catalog using GridView.builder (image placeholder, name, price) with 3 columns.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q01ProductCatalogGridScreen(),
  ));
}

class Product {
  final String name;
  final double price;
  final IconData icon;
  final Color badgeColor;

  const Product({
    required this.name,
    required this.price,
    required this.icon,
    required this.badgeColor,
  });
}

class Q01ProductCatalogGridScreen extends StatelessWidget {
  const Q01ProductCatalogGridScreen({super.key});

  final List<Product> products = const [
    Product(name: 'MacBook Pro', price: 129999, icon: Icons.laptop_mac, badgeColor: Colors.blue),
    Product(name: 'iPhone 16 Pro', price: 119999, icon: Icons.phone_iphone, badgeColor: Colors.deepPurple),
    Product(name: 'iPad Air', price: 59999, icon: Icons.tablet_mac, badgeColor: Colors.teal),
    Product(name: 'AirPods Max', price: 54999, icon: Icons.headphones, badgeColor: Colors.amber),
    Product(name: 'Apple Watch', price: 41999, icon: Icons.watch, badgeColor: Colors.pink),
    Product(name: 'Studio Display', price: 149999, icon: Icons.desktop_mac, badgeColor: Colors.indigo),
    Product(name: 'Magic Keyboard', price: 9999, icon: Icons.keyboard, badgeColor: Colors.cyan),
    Product(name: 'Magic Mouse', price: 7999, icon: Icons.mouse, badgeColor: Colors.brown),
    Product(name: 'HomePod Mini', price: 10999, icon: Icons.speaker, badgeColor: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q1: 3-Column Catalog'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image placeholder area
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: product.badgeColor.withValues(alpha: 0.12),
                      child: Center(
                        child: Icon(product.icon, size: 44, color: product.badgeColor),
                      ),
                    ),
                  ),
                  // Details area
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
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
