// Module V - Practical 5: Display SQLite Table Records in ListView
// Write a Flutter app to display all records from an SQLite table using a ListView.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

class ModuleVQ05SqliteListViewDisplay extends StatefulWidget {
  const ModuleVQ05SqliteListViewDisplay({super.key});

  @override
  State<ModuleVQ05SqliteListViewDisplay> createState() => _ModuleVQ05SqliteListViewDisplayState();
}

class _ModuleVQ05SqliteListViewDisplayState extends State<ModuleVQ05SqliteListViewDisplay> {
  Database? _db;
  List<Map<String, dynamic>> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAndLoad();
  }

  Future<void> _initAndLoad() async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'books_library_roll35.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            category TEXT,
            copies INTEGER
          )
        ''');
        await db.insert('books', {'title': 'Flutter in Action', 'author': 'Eric Windmill', 'category': 'Mobile Dev', 'copies': 5});
        await db.insert('books', {'title': 'Clean Code', 'author': 'Robert C. Martin', 'category': 'Software Engineering', 'copies': 8});
        await db.insert('books', {'title': 'Designing Data-Intensive Apps', 'author': 'Martin Kleppmann', 'category': 'Systems', 'copies': 4});
        await db.insert('books', {'title': 'Dart Apprentice', 'author': 'Raywenderlich Team', 'category': 'Language', 'copies': 6});
      },
    );

    await _fetchRecords();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchRecords() async {
    if (_db == null) return;
    final data = await _db!.query('books', orderBy: 'id ASC');
    setState(() {
      _records = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q5: SQLite ListView Display'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchRecords,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Library Books Catalog',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text('${_records.length} Titles'),
                        backgroundColor: Colors.indigo.shade50,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Direct SQL query (SELECT * FROM books) rendered into ListView.builder:'),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _records.length,
                      itemBuilder: (context, index) {
                        final book = _records[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo.shade100,
                              child: Text('${book['id']}', style: TextStyle(color: Colors.indigo.shade900, fontWeight: FontWeight.bold)),
                            ),
                            title: Text(book['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${book['author']} • ${book['category']}'),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.green.shade200),
                              ),
                              child: Text(
                                '${book['copies']} copies',
                                style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
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
