// Module IV - Level 2: Moderate (Practicals 1 to 10)
// Advanced File persistence, Student JSON serialization, Cache-first loader, SharedPreferences lists, and offline queue

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Q2: Student class with toJson and fromJson
class StudentModel {
  final String name;
  final int rollNumber;
  final String department;
  final double cpi;

  StudentModel({
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.cpi,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'rollNumber': rollNumber,
        'department': department,
        'cpi': cpi,
      };

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        name: json['name'] as String,
        rollNumber: json['rollNumber'] as int,
        department: json['department'] as String,
        cpi: (json['cpi'] as num).toDouble(),
      );
}

class ModuleIVModeratePracticals extends StatefulWidget {
  const ModuleIVModeratePracticals({super.key});

  @override
  State<ModuleIVModeratePracticals> createState() => _ModuleIVModeratePracticalsState();
}

class _ModuleIVModeratePracticalsState extends State<ModuleIVModeratePracticals> {
  // Q1 & Q7: Notes File (overwrite vs append)
  final TextEditingController _noteController = TextEditingController();
  String _fileNotesDisplay = 'No notes saved yet.';

  // Q2: Student Model Serialization
  String _serializationOutput = 'Tap button below to test StudentModel toJson/fromJson round-trip.';

  // Q3: SharedPreferences List<String>
  List<String> _persistedSkillsList = [];
  final TextEditingController _skillInputController = TextEditingController();

  // Q4 & Q5: Cache-first loader & Clear Cache
  final Map<String, String> _networkCache = {};
  String _cacheLoaderLog = 'No API calls made yet.';

  // Q6: Theme preference
  bool _darkThemeEnabled = false;

  // Q8: List<Student> stored as JSON in file
  List<StudentModel> _studentsFromFile = [];

  // Q10: Offline Form Queue
  List<String> _offlineQueue = [];

  @override
  void initState() {
    super.initState();
    _loadAllInitialData();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _skillInputController.dispose();
    super.dispose();
  }

  Future<void> _loadAllInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _persistedSkillsList = prefs.getStringList('mod4_skills_list') ?? ['Flutter', 'Dart', 'State Management'];
      _darkThemeEnabled = prefs.getBool('mod4_dark_theme') ?? false;
      _offlineQueue = prefs.getStringList('mod4_offline_queue') ?? [];
    });
    await _loadNotesFromFile();
    await _loadStudentsFromFile();
  }

  // Q1: Save note to file
  Future<void> _saveNoteToFile() async {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/moderate_notes_roll35.txt');
    await file.writeAsString(text);
    _noteController.clear();
    await _loadNotesFromFile();
  }

  // Q7: Append new text to file
  Future<void> _appendNoteToFile() async {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/moderate_notes_roll35.txt');
    await file.writeAsString('\n[${DateTime.now().toIso8601String().substring(11, 19)}] $text', mode: FileMode.append);
    _noteController.clear();
    await _loadNotesFromFile();
  }

  Future<void> _loadNotesFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/moderate_notes_roll35.txt');
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() => _fileNotesDisplay = content);
      }
    } catch (_) {}
  }

  // Q2: Test StudentModel serialization
  void _testStudentSerialization() {
    final student = StudentModel(name: 'Vadgama Priya Ashokbhai', rollNumber: 35, department: 'B.C.A. (C.S. & I.T.)', cpi: 9.15);
    final jsonMap = student.toJson();
    final jsonString = jsonEncode(jsonMap);

    final decodedMap = jsonDecode(jsonString);
    final deserializedStudent = StudentModel.fromJson(decodedMap);

    setState(() {
      _serializationOutput = '1. Original Object: ${student.name} (Roll: ${student.rollNumber})\n'
          '2. toJson() Output: $jsonString\n'
          '3. fromJson() Result: ${deserializedStudent.name} (CPI: ${deserializedStudent.cpi})';
    });
  }

  // Q3: Add skill to SharedPreferences List<String>
  Future<void> _addSkillToList() async {
    final skill = _skillInputController.text.trim();
    if (skill.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final updated = List<String>.from(_persistedSkillsList)..add(skill);
    await prefs.setStringList('mod4_skills_list', updated);
    setState(() {
      _persistedSkillsList = updated;
      _skillInputController.clear();
    });
  }

  // Q4: Cache-first data loader
  Future<void> _fetchWithCacheFirst(String endpoint) async {
    if (_networkCache.containsKey(endpoint)) {
      setState(() {
        _cacheLoaderLog = '⚡ [CACHE-HIT]: Retrieved from memory without network call -> ${_networkCache[endpoint]}';
      });
    } else {
      setState(() {
        _cacheLoaderLog = '🌐 [CACHE-MISS]: Fetching from network...';
      });
      await Future.delayed(const Duration(milliseconds: 600)); // Simulate HTTP latency
      final freshData = 'Fresh payload from "$endpoint" (Fetched at ${DateTime.now().toIso8601String().substring(14, 19)})';
      _networkCache[endpoint] = freshData;
      setState(() {
        _cacheLoaderLog = '✅ [NETWORK-FETCHED & CACHED]: $freshData';
      });
    }
  }

  // Q5: Clear cache
  void _clearCache() {
    setState(() {
      _networkCache.clear();
      _cacheLoaderLog = '🧹 [CACHE CLEARED]: Memory map is now empty. Next request will fetch fresh data.';
    });
  }

  // Q6: Toggle Theme
  Future<void> _toggleTheme(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mod4_dark_theme', val);
    setState(() => _darkThemeEnabled = val);
  }

  // Q8: List<Student> stored as JSON in file
  Future<void> _saveStudentsToFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/students_list_roll35.json');
    final students = [
      StudentModel(name: 'Vadgama Priya Ashokbhai', rollNumber: 35, department: 'B.C.A. (C.S. & I.T.)', cpi: 9.15),
      StudentModel(name: 'Aarav Patel', rollNumber: 22, department: 'Information Tech', cpi: 8.85),
      StudentModel(name: 'Pooja Shah', rollNumber: 23, department: 'B.C.A. (C.S. & I.T.)', cpi: 9.02),
    ];
    final jsonList = students.map((s) => s.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
    await _loadStudentsFromFile();
  }

  Future<void> _loadStudentsFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/students_list_roll35.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> decoded = jsonDecode(content);
        setState(() {
          _studentsFromFile = decoded.map((e) => StudentModel.fromJson(e as Map<String, dynamic>)).toList();
        });
      }
    } catch (_) {}
  }

  // Q10: Save unsent form to offline queue
  Future<void> _enqueueOfflineForm(String submission) async {
    final prefs = await SharedPreferences.getInstance();
    final updated = List<String>.from(_offlineQueue)..add('[${DateTime.now().toIso8601String().substring(11, 19)}] $submission');
    await prefs.setStringList('mod4_offline_queue', updated);
    setState(() => _offlineQueue = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod IV - Moderate (Q1 to Q10)'),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Q1 & Q7: Notes File (Overwrite vs Append)
          _buildCard(
            title: 'Q1 & Q7: Local File Notes (Save & Append)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey.shade100,
                  child: Text(_fileNotesDisplay, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                ),
                const SizedBox(height: 10),
                TextField(controller: _noteController, decoration: const InputDecoration(labelText: 'Type Note Content', border: OutlineInputBorder())),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(onPressed: _saveNoteToFile, child: const Text('Q1: Overwrite File')),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: _appendNoteToFile, child: const Text('Q7: Append to File')),
                  ],
                ),
              ],
            ),
          ),

          // Q2: Student toJson / fromJson
          _buildCard(
            title: 'Q2: Student Model Serialization',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_serializationOutput, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.indigo)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _testStudentSerialization,
                  icon: const Icon(Icons.sync_alt),
                  label: const Text('Execute toJson() & fromJson() Test'),
                ),
              ],
            ),
          ),

          // Q3: SharedPreferences List<String>
          _buildCard(
            title: 'Q3: SharedPreferences List<String> (ListView)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  children: _persistedSkillsList.map((s) => Chip(label: Text(s))).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: TextField(controller: _skillInputController, decoration: const InputDecoration(hintText: 'Add new skill...'))),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: _addSkillToList, child: const Text('Add & Persist')),
                  ],
                ),
              ],
            ),
          ),

          // Q4 & Q5: Cache-First Loader & Clear Cache
          _buildCard(
            title: 'Q4 & Q5: Cache-First Loader & Clear Cache',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_cacheLoaderLog, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.teal)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(onPressed: () => _fetchWithCacheFirst('https://api.college.edu/profile'), child: const Text('Fetch Profile API')),
                    const SizedBox(width: 8),
                    OutlinedButton(onPressed: _clearCache, child: const Text('Clear Cache')),
                  ],
                ),
              ],
            ),
          ),

          // Q6: Theme Preference
          _buildCard(
            title: 'Q6: Theme Preference in SharedPreferences',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Theme Enabled: $_darkThemeEnabled', style: const TextStyle(fontSize: 14)),
                Switch(value: _darkThemeEnabled, onChanged: _toggleTheme),
              ],
            ),
          ),

          // Q8: List<Student> JSON File Storage
          _buildCard(
            title: 'Q8: List<Student> Stored as JSON in File',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_studentsFromFile.isEmpty)
                  const Text('No students currently in file.')
                else
                  ..._studentsFromFile.map((s) => Text('• ${s.name} (Roll: ${s.rollNumber}, CPI: ${s.cpi})')),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _saveStudentsToFile, child: const Text('Save 3 Students to File & Read Back')),
              ],
            ),
          ),

          // Q10: Offline Submission Queue
          _buildCard(
            title: 'Q10: Offline Form Queue in SharedPreferences',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Queued Items for Online Sync (${_offlineQueue.length}):', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                if (_offlineQueue.isEmpty)
                  const Text('Queue is empty.')
                else
                  ..._offlineQueue.map((item) => Text(item, style: const TextStyle(fontSize: 12))),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => _enqueueOfflineForm('Assignment Submission: Unit 5 Persistence'),
                  icon: const Icon(Icons.cloud_off),
                  label: const Text('Enqueue Offline Form'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.teal)),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}
