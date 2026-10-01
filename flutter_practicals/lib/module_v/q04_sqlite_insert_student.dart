// Module V - Practical 4: Insert Record into SQLite "students" Table
// Write a Flutter app to insert a new record into the "students" table using SQLite.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

class ModuleVQ04SqliteInsertStudent extends StatefulWidget {
  const ModuleVQ04SqliteInsertStudent({super.key});

  @override
  State<ModuleVQ04SqliteInsertStudent> createState() => _ModuleVQ04SqliteInsertStudentState();
}

class _ModuleVQ04SqliteInsertStudentState extends State<ModuleVQ04SqliteInsertStudent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Vadgama Priya Ashokbhai');
  final _rollController = TextEditingController(text: '35');
  final _deptController = TextEditingController(text: 'B.C.A. (C.S. & I.T.)');

  Database? _db;
  List<Map<String, dynamic>> _studentList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _deptController.dispose();
    super.dispose();
  }

  Future<void> _initDatabase() async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'students_records_roll35.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            roll_number INTEGER NOT NULL,
            department TEXT NOT NULL
          )
        ''');
      },
    );

    await _fetchStudents();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchStudents() async {
    if (_db == null) return;
    final list = await _db!.query('students', orderBy: 'id DESC');
    setState(() {
      _studentList = list;
    });
  }

  Future<void> _insertStudent() async {
    if (!_formKey.currentState!.validate() || _db == null) return;

    final name = _nameController.text.trim();
    final roll = int.parse(_rollController.text.trim());
    final dept = _deptController.text.trim();

    final insertedId = await _db!.insert('students', {
      'name': name,
      'roll_number': roll,
      'department': dept,
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student inserted successfully (Record ID: $insertedId)!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    _rollController.clear();
    await _fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q4: SQLite Insert Student'),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Insert New Student Record',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(labelText: 'Student Name', prefixIcon: Icon(Icons.person)),
                              validator: (v) => v!.isEmpty ? 'Enter student name' : null,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _rollController,
                              decoration: const InputDecoration(labelText: 'Roll Number', prefixIcon: Icon(Icons.badge)),
                              keyboardType: TextInputType.number,
                              validator: (v) => v!.isEmpty ? 'Enter roll number' : null,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _deptController,
                              decoration: const InputDecoration(labelText: 'Department', prefixIcon: Icon(Icons.school)),
                              validator: (v) => v!.isEmpty ? 'Enter department' : null,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _insertStudent,
                                icon: const Icon(Icons.add_circle),
                                label: const Text('Execute SQLite INSERT'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal.shade800,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Current Students in SQLite DB (${_studentList.length}):',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (_studentList.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(child: Text('No records inserted yet.')),
                    )
                  else
                    ..._studentList.map(
                      (s) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal.shade50,
                            child: Text('${s['roll_number']}', style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.bold)),
                          ),
                          title: Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${s['department']} • DB ID: ${s['id']}'),
                          trailing: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
