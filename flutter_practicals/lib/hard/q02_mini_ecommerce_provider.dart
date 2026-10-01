import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Hard Level - Practical 2:
/// Build a complete mini E-commerce app using Provider:
/// Product List (GridView.builder) -> Cart (Provider) -> Checkout Summary (passing data via Navigation).

class EcomProduct {
  final String id;
  final String title;
  final double price;
  final IconData icon;
  final Color themeColor;

  const EcomProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.icon,
    required this.themeColor,
  });
}

class CartProvider extends ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get items => _items;

  int get totalItemCount => _items.values.fold(0, (sum, count) => sum + count);

  double calculateTotal(List<EcomProduct> catalog) {
    double sum = 0;
    _items.forEach((id, qty) {
      final prod = catalog.firstWhere((p) => p.id == id);
      sum += prod.price * qty;
    });
    return sum;
  }

  void addToCart(String productId) {
    _items[productId] = (_items[productId] ?? 0) + 1;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]! > 1) {
        _items[productId] = _items[productId]! - 1;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

final List<EcomProduct> sampleCatalog = [
  const EcomProduct(id: '1', title: 'Noise-Cancelling Headphones', price: 9999, icon: Icons.headphones, themeColor: Colors.deepPurple),
  const EcomProduct(id: '2', title: 'Smart Fitness Band', price: 2999, icon: Icons.watch, themeColor: Colors.teal),
  const EcomProduct(id: '3', title: 'Mechanical Gaming Keyboard', price: 4499, icon: Icons.keyboard, themeColor: Colors.orange),
  const EcomProduct(id: '4', title: 'Ergonomic Vertical Mouse', price: 2499, icon: Icons.mouse, themeColor: Colors.indigo),
  const EcomProduct(id: '5', title: '4K Ultra HD Webcam', price: 6999, icon: Icons.videocam, themeColor: Colors.pink),
  const EcomProduct(id: '6', title: 'Aluminum Laptop Stand', price: 1899, icon: Icons.laptop, themeColor: Colors.cyan),
];

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EcomCatalogScreen(),
      ),
    ),
  );
}

// 1. Catalog Screen
class EcomCatalogScreen extends StatelessWidget {
  const EcomCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (context) {
          final cart = context.watch<CartProvider>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mini E-Commerce Store'),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              actions: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ChangeNotifierProvider.value(
                              value: context.read<CartProvider>(),
                              child: const EcomCartScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    if (cart.totalItemCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            '${cart.totalItemCount}',
                            style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sampleCatalog.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = sampleCatalog[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: product.themeColor.withValues(alpha: 0.15),
                          child: Icon(product.icon, size: 36, color: product.themeColor),
                        ),
                        Text(
                          product.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('₹${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                            onPressed: () => context.read<CartProvider>().addToCart(product.id),
                            child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 2. Cart Screen
class EcomCartScreen extends StatelessWidget {
  const EcomCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final cartItemEntries = cart.items.entries.toList();
    final total = cart.calculateTotal(sampleCatalog);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Shopping Cart'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: cartItemEntries.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemEntries.length,
                    itemBuilder: (context, index) {
                      final entry = cartItemEntries[index];
                      final product = sampleCatalog.firstWhere((p) => p.id == entry.key);
                      final qty = entry.value;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: product.themeColor.withValues(alpha: 0.2),
                          child: Icon(product.icon, color: product.themeColor),
                        ),
                        title: Text(product.title),
                        subtitle: Text('₹${product.price.toStringAsFixed(0)} x $qty = ₹${(product.price * qty).toStringAsFixed(0)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.removeFromCart(product.id),
                            ),
                            Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.addToCart(product.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:', style: TextStyle(fontSize: 18)),
                          Text('₹${total.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Proceed to Checkout Summary'),
                          onPressed: () {
                            // Passing data via Navigator to Checkout Summary
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => EcomCheckoutSummaryScreen(
                                  totalAmount: total,
                                  itemCount: cart.totalItemCount,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// 3. Checkout Summary Screen
class EcomCheckoutSummaryScreen extends StatelessWidget {
  final double totalAmount;
  final int itemCount;

  const EcomCheckoutSummaryScreen({
    super.key,
    required this.totalAmount,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    const double deliveryFee = 99.0;
    final grandTotal = totalAmount + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Summary'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.receipt_long, size: 70, color: Colors.green),
            const SizedBox(height: 16),
            const Text('Order Invoice', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            _row('Items Ordered', '$itemCount items'),
            _row('Subtotal', '₹${totalAmount.toStringAsFixed(2)}'),
            _row('Standard Delivery', '₹${deliveryFee.toStringAsFixed(2)}'),
            const Divider(height: 24),
            _row('Grand Total', '₹${grandTotal.toStringAsFixed(2)}', isBold: true),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.done_all),
              label: const Text('Pay & Place Order'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Order Confirmed!'),
                    content: Text('Your payment of ₹${grandTotal.toStringAsFixed(2)} was successful.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text('Return to Home'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isBold ? 18 : 15, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: isBold ? 20 : 15, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? Colors.green : Colors.black87)),
        ],
      ),
    );
  }
}
