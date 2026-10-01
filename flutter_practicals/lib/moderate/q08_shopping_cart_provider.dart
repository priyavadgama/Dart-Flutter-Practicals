import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Moderate Level - Practical 8:
/// Create a Shopping Cart using Provider where the total price updates
/// automatically as items are added/removed.

class Item {
  final String id;
  final String name;
  final double price;
  final IconData icon;

  const Item({required this.id, required this.name, required this.price, required this.icon});
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  double get totalPrice => _items.fold(0.0, (total, item) => total + item.price);

  int get itemCount => _items.length;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Q08ShoppingCartScreen(),
      ),
    ),
  );
}

class Q08ShoppingCartScreen extends StatelessWidget {
  const Q08ShoppingCartScreen({super.key});

  final List<Item> catalog = const [
    Item(id: '1', name: 'Mechanical Keyboard', price: 4500, icon: Icons.keyboard),
    Item(id: '2', name: 'Wireless Mouse', price: 1800, icon: Icons.mouse),
    Item(id: '3', name: 'Noise-Canceling Headphones', price: 12000, icon: Icons.headphones),
    Item(id: '4', name: 'USB-C Fast Charger', price: 1999, icon: Icons.power),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Moderate Q8: Shopping Cart (Provider)'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            // Available Catalog Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Available Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: catalog.length,
                itemBuilder: (context, index) {
                  final item = catalog[index];
                  return Container(
                    width: 170,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, color: Colors.indigo),
                            Text(item.name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('₹${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Consumer<CartModel>(
                              builder: (context, cart, child) {
                                return SizedBox(
                                  height: 28,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    onPressed: () => cart.addItem(item),
                                    child: const Text('Add to Cart', style: TextStyle(fontSize: 11)),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 24),
            // Cart Items Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<CartModel>(
                    builder: (context, cart, child) => Text(
                      'Cart Items (${cart.itemCount})',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Consumer<CartModel>(
                    builder: (context, cart, child) => TextButton(
                      onPressed: cart.itemCount > 0 ? cart.clearCart : null,
                      child: const Text('Clear All'),
                    ),
                  ),
                ],
              ),
            ),
            // Cart List
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  if (cart.itemCount == 0) {
                    return const Center(child: Text('Your cart is empty. Add items from above!'));
                  }
                  return ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Icon(item.icon, color: Colors.indigo),
                        title: Text(item.name),
                        subtitle: Text('₹${item.price.toStringAsFixed(0)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => cart.removeItem(index),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Bottom Checkout Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, -4)),
                ],
              ),
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Price:', style: TextStyle(color: Colors.grey)),
                          Text(
                            '₹${cart.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        icon: const Icon(Icons.payment),
                        label: const Text('Checkout'),
                        onPressed: cart.itemCount > 0
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Order placed for ₹${cart.totalPrice.toStringAsFixed(2)}!')),
                                );
                              }
                            : null,
                      ),
                    ],
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
