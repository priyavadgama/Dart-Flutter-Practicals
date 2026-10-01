// Module V - Practical 6: Update Record in SQLite Table by ID
// Write a Flutter app to update a specific record in an SQLite table based on its id.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

class ModuleVQ06SqliteUpdateRecord extends StatefulWidget {
  const ModuleVQ06SqliteUpdateRecord({super.key});

  @override
  State<ModuleVQ06SqliteUpdateRecord> createState() => _ModuleVQ06SqliteUpdateRecordState();
}

class _ModuleVQ06SqliteUpdateRecordState extends State<ModuleVQ06SqliteUpdateRecord> {
  Database? _db;
  List<Map<String, dynamic>> _employees = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'employees_update_demo_roll35.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE employees (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            designation TEXT,
            salary REAL
          )
        ''');
        await db.insert('employees', {'name': 'Vadgama Priya Ashokbhai', 'designation': 'Junior Flutter Dev', 'salary': 45000.0});
        await db.insert('employees', {'name': 'Aarav Sharma', 'designation': 'Frontend Engineer', 'salary': 40000.0});
        await db.insert('employees', {'name': 'Neha Verma', 'designation': 'QA Engineer', 'salary': 38000.0});
      },
    );

    await _loadEmployees();
    setState(() => _isLoading = false);
  }

  Future<void> _loadEmployees() async {
    if (_db == null) return;
    final list = await _db!.query('employees', orderBy: 'id ASC');
    setState(() => _employees = list);
  }

  Future<void> _updateEmployee(int id, String name, String designation, double salary) async {
    if (_db == null) return;
    // Execute SQL UPDATE where id = ?
    await _db!.update(
      'employees',
      {'name': name, 'designation': designation, 'salary': salary},
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee ID #$id updated successfully!'), backgroundColor: Colors.green),
      );
    }
    await _loadEmployees();
  }

  void _showEditDialog(Map<String, dynamic> emp) {
    final nameCtrl = TextEditingController(text: emp['name'] as String);
    final desigCtrl = TextEditingController(text: emp['designation'] as String);
    final salCtrl = TextEditingController(text: emp['salary'].toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit Employee (ID: ${emp['id']})'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: desigCtrl, decoration: const InputDecoration(labelText: 'Designation')),
              TextField(controller: salCtrl, decoration: const InputDecoration(labelText: 'Salary (₹)'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newName = nameCtrl.text.trim();
              final newDesig = desigCtrl.text.trim();
              final newSal = double.tryParse(salCtrl.text.trim()) ?? 0.0;
              if (newName.isNotEmpty && newDesig.isNotEmpty) {
                _updateEmployee(emp['id'] as int, newName, newDesig, newSal);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q6: SQLite Update by ID'),
        backgroundColor: Colors.deepPurple,
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.edit_note, color: Colors.deepPurple),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Tap the Edit icon on any record to perform an SQL UPDATE operation targeting that record’s unique Primary Key (id).',
                            style: TextStyle(fontSize: 12, color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _employees.length,
                      itemBuilder: (context, index) {
                        final emp = _employees[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple.shade100,
                              child: Text('${emp['id']}', style: TextStyle(color: Colors.deepPurple.shade900, fontWeight: FontWeight.bold)),
                            ),
                            title: Text(emp['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${emp['designation']} • ₹${emp['salary']} / month'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.deepPurple),
                              onPressed: () => _showEditDialog(emp),
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
