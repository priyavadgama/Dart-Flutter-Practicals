// Module V - Practical 3: SQLite Database with "products" Table
// Create an SQLite database with a table named "products" having columns id, name, and price.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

class ModuleVQ03SqliteProductsTable extends StatefulWidget {
  const ModuleVQ03SqliteProductsTable({super.key});

  @override
  State<ModuleVQ03SqliteProductsTable> createState() => _ModuleVQ03SqliteProductsTableState();
}

class _ModuleVQ03SqliteProductsTableState extends State<ModuleVQ03SqliteProductsTable> {
  Database? _db;
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  String _statusMessage = 'Initializing database...';

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      // Support macOS desktop test runner
      if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      final dbPath = await getDatabasesPath();
      final path = p.join(dbPath, 'products_demo_roll35.db');

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          // CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price REAL)
          await db.execute('''
            CREATE TABLE products (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              price REAL NOT NULL
            )
          ''');
          // Seed with initial items
          await db.insert('products', {'name': 'Flutter Pro Laptop Stand', 'price': 1499.0});
          await db.insert('products', {'name': 'Mechanical Coding Keyboard', 'price': 4299.0});
          await db.insert('products', {'name': 'Ergonomic Developer Mouse', 'price': 2199.0});
        },
      );

      await _refreshProductList();
      setState(() {
        _statusMessage = 'Database connected: "products" table ready.';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'SQLite Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshProductList() async {
    if (_db == null) return;
    final data = await _db!.query('products', orderBy: 'id ASC');
    setState(() {
      _products = data;
    });
  }

  Future<void> _insertProduct(String name, double price) async {
    if (_db == null) return;
    await _db!.insert('products', {'name': name, 'price': price});
    await _refreshProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q3: SQLite Products Table'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SQL Schema Definition:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'CREATE TABLE products (\n  id INTEGER PRIMARY KEY AUTOINCREMENT,\n  name TEXT,\n  price REAL\n);',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                        Text(_statusMessage, style: const TextStyle(fontSize: 12, color: Colors.green)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stored Records (${_products.length})',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showAddProductDialog();
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Product'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _products.isEmpty
                        ? const Center(child: Text('No products in database.'))
                        : ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final p = _products[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.indigo.shade100,
                                    child: Text('${p['id']}', style: TextStyle(color: Colors.indigo.shade900, fontWeight: FontWeight.bold)),
                                  ),
                                  title: Text(p['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('Price: ₹${p['price']}'),
                                  trailing: const Icon(Icons.inventory_2, color: Colors.indigo),
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

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add SQLite Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price (₹)'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text.trim()) ?? 0.0;
              if (name.isNotEmpty && price > 0) {
                _insertProduct(name, price);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Insert Record'),
          ),
        ],
      ),
    );
  }
}
