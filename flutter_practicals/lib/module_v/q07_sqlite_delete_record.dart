// Module V - Practical 7: Delete Record from SQLite Table by ID
// Write a Flutter app to delete a specific record from an SQLite table based on its id.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

class ModuleVQ07SqliteDeleteRecord extends StatefulWidget {
  const ModuleVQ07SqliteDeleteRecord({super.key});

  @override
  State<ModuleVQ07SqliteDeleteRecord> createState() => _ModuleVQ07SqliteDeleteRecordState();
}

class _ModuleVQ07SqliteDeleteRecordState extends State<ModuleVQ07SqliteDeleteRecord> {
  Database? _db;
  List<Map<String, dynamic>> _tasks = [];
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
    final path = p.join(dbPath, 'tasks_delete_demo_roll35.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE task_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            priority TEXT
          )
        ''');
        await db.insert('task_items', {'title': 'Submit Dart Practicals 1-30', 'priority': 'High'});
        await db.insert('task_items', {'title': 'Implement Flutter UI Modules', 'priority': 'High'});
        await db.insert('task_items', {'title': 'Prepare College Project Documentation', 'priority': 'Medium'});
        await db.insert('task_items', {'title': 'Conduct Code Review and Cleanup', 'priority': 'Low'});
      },
    );

    await _loadTasks();
    setState(() => _isLoading = false);
  }

  Future<void> _loadTasks() async {
    if (_db == null) return;
    final list = await _db!.query('task_items', orderBy: 'id ASC');
    setState(() => _tasks = list);
  }

  Future<void> _deleteTask(int id, String title) async {
    if (_db == null) return;
    // Execute SQL DELETE WHERE id = ?
    await _db!.delete(
      'task_items',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted task: "$title" (ID: $id)'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    await _loadTasks();
  }

  void _confirmDelete(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete "${task['title']}" (ID #${task['id']}) from SQLite database?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _deleteTask(task['id'] as int, task['title'] as String);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q7: SQLite Delete by ID'),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
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
                      Text('Tasks in Database (${_tasks.length})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      if (_tasks.isEmpty)
                        ElevatedButton(
                          onPressed: () async {
                            await _db!.insert('task_items', {'title': 'New Practical Task', 'priority': 'Normal'});
                            _loadTasks();
                          },
                          child: const Text('Reset Sample Task'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _tasks.isEmpty
                        ? const Center(child: Text('All tasks deleted from SQLite!'))
                        : ListView.builder(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                              final task = _tasks[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.red.shade50,
                                    child: Text('${task['id']}', style: TextStyle(color: Colors.red.shade900, fontWeight: FontWeight.bold)),
                                  ),
                                  title: Text(task['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('Priority: ${task['priority']}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _confirmDelete(task),
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
