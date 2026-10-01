import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 3:
/// Design an e-commerce style product detail screen using Stack for the image
/// with an overlay discount badge, Wrap for tag chips, and Expanded/Flexible
/// for the price and Add-to-Cart button row.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q03ProductDetailScreen(),
  ));
}

class Q03ProductDetailScreen extends StatefulWidget {
  const Q03ProductDetailScreen({super.key});

  @override
  State<Q03ProductDetailScreen> createState() => _Q03ProductDetailScreenState();
}

class _Q03ProductDetailScreenState extends State<Q03ProductDetailScreen> {
  final List<String> tags = [
    'Wireless Audio',
    'Active Noise Cancellation',
    'Spatial Sound',
    '40h Battery Life',
    'USB-C Fast Charge',
    'Bluetooth 5.3',
    'Memory Foam Earcups',
  ];

  int _selectedColorIndex = 0;
  final List<Color> colorVariants = [Colors.indigo, Colors.black87, Colors.blueGrey, Colors.teal];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ================= 1. STACK WITH OVERLAY DISCOUNT BADGE =================
            Stack(
              children: [
                // Product hero visual
                Container(
                  height: 280,
                  width: double.infinity,
                  color: colorVariants[_selectedColorIndex].withValues(alpha: 0.08),
                  child: Center(
                    child: Icon(
                      Icons.headphones,
                      size: 140,
                      color: colorVariants[_selectedColorIndex],
                    ),
                  ),
                ),
                // Overlay Discount Badge
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          '35% OFF SPECIAL',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                // Rating pill
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text('4.9 (1.2k Reviews)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Apex Pro ANC Wireless Headphones',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Engineered for acoustic precision with custom 40mm titanium drivers and intelligent environmental noise cancellation.',
                    style: TextStyle(color: Colors.grey, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Colour Finish', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(colorVariants.length, (index) {
                      final isSelected = index == _selectedColorIndex;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColorIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: isSelected ? Colors.indigo : Colors.transparent, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: colorVariants[index],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // ================= 2. WRAP FOR TAG CHIPS =================
                  const Text('Product Key Specifications', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: tags.map((tag) {
                      return Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                        backgroundColor: Colors.indigo.shade50,
                        side: BorderSide(color: Colors.indigo.shade200),
                        avatar: const Icon(Icons.check_circle_outline, size: 16, color: Colors.indigo),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ================= 3. EXPANDED / FLEXIBLE BOTTOM ACTION ROW =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -3)),
          ],
        ),
        child: Row(
          children: [
            // Flexible / Expanded price display
            const Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Offer:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Row(
                    children: [
                      Text(
                        '₹12,999',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '₹19,999',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Expanded Add to Cart action button
            Expanded(
              flex: 5,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to Cart', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added Apex Pro Headphones to your shopping cart!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
