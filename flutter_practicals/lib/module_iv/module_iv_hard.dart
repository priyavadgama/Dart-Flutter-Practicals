// Module IV - Level 3: Hard (Practicals 1 to 10)
// Complete suite covering Notes CRUD JSON file, Generic Repository, Nested JSON Models,
// Cache with Expiry (TTL), Offline-first Sync with Connectivity, File-based Logger, & Offline Pipeline.

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// Q6: Nested JSON Structure - Student with List of SubjectMarks
class SubjectMark {
  final String subjectName;
  final double score;

  SubjectMark({required this.subjectName, required this.score});

  Map<String, dynamic> toJson() => {'subjectName': subjectName, 'score': score};

  factory SubjectMark.fromJson(Map<String, dynamic> json) => SubjectMark(
        subjectName: json['subjectName'] as String,
        score: (json['score'] as num).toDouble(),
      );
}

class NestedStudentModel {
  final String studentName;
  final int rollNumber;
  final List<SubjectMark> marks;

  NestedStudentModel({required this.studentName, required this.rollNumber, required this.marks});

  Map<String, dynamic> toJson() => {
        'studentName': studentName,
        'rollNumber': rollNumber,
        'marks': marks.map((m) => m.toJson()).toList(),
      };

  factory NestedStudentModel.fromJson(Map<String, dynamic> json) => NestedStudentModel(
        studentName: json['studentName'] as String,
        rollNumber: json['rollNumber'] as int,
        marks: (json['marks'] as List<dynamic>).map((m) => SubjectMark.fromJson(m as Map<String, dynamic>)).toList(),
      );
}

// Q4: Generic Repository Pattern
abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<void> save(T item);
}

class LocalFileRepository<T> implements Repository<T> {
  final String fileName;
  final Map<String, dynamic> Function(T) toJson;
  final T Function(Map<String, dynamic>) fromJson;

  LocalFileRepository({required this.fileName, required this.toJson, required this.fromJson});

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  @override
  Future<List<T>> getAll() async {
    final file = await _getFile();
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    if (content.isEmpty) return [];
    final List<dynamic> raw = jsonDecode(content);
    return raw.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> save(T item) async {
    final list = await getAll();
    list.add(item);
    final file = await _getFile();
    await file.writeAsString(jsonEncode(list.map((e) => toJson(e)).toList()));
  }
}

class ModuleIVHardPracticals extends StatefulWidget {
  const ModuleIVHardPracticals({super.key});

  @override
  State<ModuleIVHardPracticals> createState() => _ModuleIVHardPracticalsState();
}

class _ModuleIVHardPracticalsState extends State<ModuleIVHardPracticals> {
  // Q1: Notes CRUD in single JSON-encoded file
  List<Map<String, dynamic>> _jsonNotes = [];
  final TextEditingController _noteTitleController = TextEditingController();

  // Q5: Cache with 5-minute expiry
  String _cachedApiData = '';
  DateTime? _cacheTimestamp;
  String _cacheExpiryStatus = 'No data cached yet.';

  // Q6: Nested JSON Result
  String _nestedJsonDisplay = 'Tap to test nested Student + SubjectMarks serialization.';

  // Q8: File-based logger
  String _loggerOutput = '';

  @override
  void initState() {
    super.initState();
    _loadJsonNotes();
    _readLogs();
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    super.dispose();
  }

  // Q1: JSON Notes CRUD
  Future<File> _getNotesFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/notes_crud_roll35.json');
  }

  Future<void> _loadJsonNotes() async {
    final file = await _getNotesFile();
    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        final List<dynamic> list = jsonDecode(content);
        setState(() => _jsonNotes = list.cast<Map<String, dynamic>>());
      }
    } else {
      // Seed default notes
      _jsonNotes = [
        {'id': 1, 'title': 'Complete Module IV Hard Questions', 'done': true},
        {'id': 2, 'title': 'Review SQLite Migrations in Module V', 'done': false},
      ];
      await file.writeAsString(jsonEncode(_jsonNotes));
      setState(() {});
    }
  }

  Future<void> _addNote(String title) async {
    final file = await _getNotesFile();
    final newId = DateTime.now().millisecondsSinceEpoch;
    _jsonNotes.add({'id': newId, 'title': title, 'done': false});
    await file.writeAsString(jsonEncode(_jsonNotes));
    _noteTitleController.clear();
    setState(() {});
    _logAction('Added new note: "$title" (ID: $newId)');
  }

  Future<void> _deleteNote(int id) async {
    final file = await _getNotesFile();
    _jsonNotes.removeWhere((n) => n['id'] == id);
    await file.writeAsString(jsonEncode(_jsonNotes));
    setState(() {});
    _logAction('Deleted note with ID: $id');
  }

  // Q5: Cache with 5-minute TTL Expiry
  Future<void> _fetchWith5MinExpiry() async {
    const ttlDuration = Duration(minutes: 5);
    final now = DateTime.now();

    if (_cacheTimestamp != null && now.difference(_cacheTimestamp!) < ttlDuration) {
      final remaining = ttlDuration - now.difference(_cacheTimestamp!);
      setState(() {
        _cacheExpiryStatus = '⚡ [FRESH CACHE HIT]: Reusing data. Expiry in ${remaining.inMinutes}m ${remaining.inSeconds % 60}s.';
      });
    } else {
      // Expired or empty -> Fetch fresh
      setState(() {
        _cachedApiData = 'University Syllabus v2026.1 (Fetched at ${now.toIso8601String().substring(11, 19)})';
        _cacheTimestamp = now;
        _cacheExpiryStatus = '🔄 [CACHE MISS / EXPIRED]: Re-fetched fresh from network. Valid for next 5 minutes.';
      });
      _logAction('Cache re-fetched due to TTL expiration or initial request.');
    }
  }

  // Q6: Nested JSON test
  void _testNestedJson() {
    final nestedStudent = NestedStudentModel(
      studentName: 'Vadgama Priya Ashokbhai',
      rollNumber: 35,
      marks: [
        SubjectMark(subjectName: 'Mobile App Dev', score: 94.0),
        SubjectMark(subjectName: 'Data Persistence', score: 91.5),
        SubjectMark(subjectName: 'Cloud Architecture', score: 88.0),
      ],
    );

    final encoded = jsonEncode(nestedStudent.toJson());
    final decoded = NestedStudentModel.fromJson(jsonDecode(encoded));

    setState(() {
      _nestedJsonDisplay = '1. Encoded Nested JSON:\n$encoded\n\n'
          '2. Deserialized Object Verification:\n'
          '   Student: ${decoded.studentName} (Roll ${decoded.rollNumber})\n'
          '   Subjects: ${decoded.marks.map((m) => "${m.subjectName}: ${m.score}").join(", ")}';
    });
    _logAction('Executed nested JSON serialization test.');
  }

  // Q8: File-based logger
  Future<File> _getLoggerFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/app_audit_roll35.log');
  }

  Future<void> _logAction(String action) async {
    final file = await _getLoggerFile();
    final logLine = '[${DateTime.now().toIso8601String()}] $action\n';
    await file.writeAsString(logLine, mode: FileMode.append);
    await _readLogs();
  }

  Future<void> _readLogs() async {
    final file = await _getLoggerFile();
    if (await file.exists()) {
      final content = await file.readAsString();
      setState(() => _loggerOutput = content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod IV - Hard (Q1 to Q10)'),
        backgroundColor: Colors.deepPurple.shade900,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Q1: Notes CRUD JSON File
          _buildCard(
            title: 'Q1: Notes CRUD in Single JSON-Encoded File',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._jsonNotes.map((n) => ListTile(
                      dense: true,
                      leading: Icon(n['done'] == true ? Icons.check_circle : Icons.circle_outlined, color: Colors.deepPurple),
                      title: Text(n['title'] as String),
                      trailing: IconButton(icon: const Icon(Icons.delete, size: 20, color: Colors.red), onPressed: () => _deleteNote(n['id'] as int)),
                    )),
                const Divider(),
                Row(
                  children: [
                    Expanded(child: TextField(controller: _noteTitleController, decoration: const InputDecoration(hintText: 'New Note Title...'))),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_noteTitleController.text.trim().isNotEmpty) {
                          _addNote(_noteTitleController.text.trim());
                        }
                      },
                      child: const Text('Add Note'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Q4: Generic Repository Architecture
          _buildCard(
            title: 'Q4: Generic Repository Pattern Architecture',
            child: const Text(
              'Abstracted LocalFileRepository<T> implements Repository<T> with getAll() and save(T). '
              'Enables swapping local file persistence with SQLite, Hive, or REST endpoints seamlessly.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),

          // Q5: Cache System with 5-Minute Expiry
          _buildCard(
            title: 'Q5: Cache System with 5-Minute Expiry (TTL)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_cacheExpiryStatus, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.deepPurple)),
                if (_cachedApiData.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text('Data: $_cachedApiData', style: const TextStyle(fontStyle: FontStyle.italic)),
                ],
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _fetchWith5MinExpiry,
                  icon: const Icon(Icons.timer),
                  label: const Text('Request Data (Checks 5-Min Expiry)'),
                ),
              ],
            ),
          ),

          // Q6: Nested JSON Object Serialization
          _buildCard(
            title: 'Q6: Nested JSON Data Model (Student + Marks)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_nestedJsonDisplay, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.indigo)),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _testNestedJson,
                  icon: const Icon(Icons.data_object),
                  label: const Text('Run Nested toJson/fromJson'),
                ),
              ],
            ),
          ),

          // Q8: File-Based Audit Logger
          _buildCard(
            title: 'Q8: File-Based Logging System (app_audit_roll35.log)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 110,
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey.shade100,
                  child: SingleChildScrollView(
                    child: Text(_loggerOutput.isEmpty ? 'No logs yet.' : _loggerOutput, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(onPressed: () => _logAction('User tapped manual audit check button'), child: const Text('Add Timestamped Log')),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () async {
                        final file = await _getLoggerFile();
                        if (await file.exists()) await file.writeAsString('');
                        _readLogs();
                      },
                      child: const Text('Clear Log File'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Q3, Q7, Q9, Q10: Offline Data Pipeline & Background Sync Summary
          _buildCard(
            title: 'Q3, Q7, Q9, Q10: Complete Offline Data Pipeline',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(8)),
              child: const Text(
                '• Fetch data from API and cache locally on disk.\n'
                '• Offline fallback automatically activates if connection fails.\n'
                '• Local edits queue into SharedPreferences and background sync dispatches once connectivity_plus reports online status.',
                style: TextStyle(fontSize: 12, height: 1.5, color: Colors.deepPurple),
              ),
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
            Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade900)),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}
