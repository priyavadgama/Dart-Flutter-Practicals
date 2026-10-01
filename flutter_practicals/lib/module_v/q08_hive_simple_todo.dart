// Module V - Practical 8: Save & Display Simple To-Do Note using Hive
// Create a Flutter app that uses Hive to save and display a simple "To-Do" note.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ModuleVQ08HiveSimpleTodo extends StatefulWidget {
  const ModuleVQ08HiveSimpleTodo({super.key});

  @override
  State<ModuleVQ08HiveSimpleTodo> createState() => _ModuleVQ08HiveSimpleTodoState();
}

class _ModuleVQ08HiveSimpleTodoState extends State<ModuleVQ08HiveSimpleTodo> {
  Box? _todoBox;
  final TextEditingController _noteController = TextEditingController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _todoBox = await Hive.openBox('todo_notes_box_roll35');
    if (_todoBox!.isEmpty) {
      await _todoBox!.put('active_note', 'Complete B.C.A. (C.S. & I.T.) practical files for submission.');
    }
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _saveNote() async {
    final note = _noteController.text.trim();
    if (note.isEmpty || _todoBox == null) return;

    await _todoBox!.put('active_note', note);
    _noteController.clear();
    setState(() {});

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('To-Do note updated in Hive NoSQL Box!'), backgroundColor: Colors.amber),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentNote = _todoBox?.get('active_note', defaultValue: 'No active to-do note stored in Hive.') as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q8: Hive To-Do Note'),
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.white,
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.sticky_note_2, color: Colors.amber),
                            SizedBox(width: 8),
                            Text('Hive NoSQL Persisted Note:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          currentNote ?? 'No note stored',
                          style: const TextStyle(fontSize: 18, color: Colors.black87, height: 1.4),
                        ),
                        const SizedBox(height: 10),
                        const Text('Stored inside: todo_notes_box_roll35 (Key: active_note)', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Write New To-Do Note',
                      hintText: 'e.g., Revise Unit 5 Flutter widgets before viva exam',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _saveNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('Save Note to Hive', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
    );
  }
}
