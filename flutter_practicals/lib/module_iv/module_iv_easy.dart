// Module IV - Level 1: Easy (Practicals 1 to 10)
// Complete suite covering File I/O, SharedPreferences, In-Memory Caching & JSON Serialization

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleIVEasyPracticals extends StatefulWidget {
  const ModuleIVEasyPracticals({super.key});

  @override
  State<ModuleIVEasyPracticals> createState() => _ModuleIVEasyPracticalsState();
}

class _ModuleIVEasyPracticalsState extends State<ModuleIVEasyPracticals> {
  // Q1: App Documents Directory
  String _docsPath = 'Not fetched yet';

  // Q2 & Q3 & Q4 & Q5: File Operations
  String _fileStatus = 'No file operations performed yet.';
  String _fileReadContent = '';

  // Q6 & Q7: SharedPreferences
  String _storedName = 'None';
  int _prefCounter = 0;

  // Q8: In-Memory Cache
  final Map<String, dynamic> _inMemoryCache = {};
  String _cacheStatus = 'Cache is empty';

  // Q9 & Q10: JSON Serialization
  String _jsonEncodedResult = '';
  String _jsonDecodedResult = '';

  @override
  void initState() {
    super.initState();
    _loadInitialPrefs();
  }

  Future<void> _loadInitialPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedName = prefs.getString('easy_q6_username') ?? 'Vadgama Priya Ashokbhai (Default)';
      _prefCounter = prefs.getInt('easy_q7_counter') ?? 0;
    });
  }

  // Q1: getApplicationDocumentsDirectory
  Future<void> _q1GetDocsDir() async {
    final dir = await getApplicationDocumentsDirectory();
    setState(() {
      _docsPath = dir.path;
    });
  }

  // Q2: writeAsString("Hello Flutter")
  Future<void> _q2WriteFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/hello_flutter_roll35.txt');
    await file.writeAsString('Hello Flutter - Vadgama Priya Ashokbhai (Roll No: 35)');
    setState(() {
      _fileStatus = 'File created & written: "Hello Flutter - Vadgama Priya Ashokbhai (Roll No: 35)"';
    });
  }

  // Q3 & Q4: Check exists() before readAsString()
  Future<void> _q3Q4ReadFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/hello_flutter_roll35.txt');
    if (await file.exists()) {
      final text = await file.readAsString();
      setState(() {
        _fileReadContent = text;
        _fileStatus = 'File verified (exists() == true) and read successfully.';
      });
    } else {
      setState(() {
        _fileReadContent = '';
        _fileStatus = 'File does not exist! Please write first (Q2).';
      });
    }
  }

  // Q5: Delete file with confirmation
  Future<void> _q5DeleteFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/hello_flutter_roll35.txt');
    if (await file.exists()) {
      await file.delete();
      setState(() {
        _fileReadContent = '';
        _fileStatus = 'File successfully deleted from disk via file.delete().';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File hello_flutter_roll35.txt deleted.'), backgroundColor: Colors.red),
        );
      }
    } else {
      setState(() {
        _fileStatus = 'Nothing to delete: File does not exist.';
      });
    }
  }

  // Q6: SharedPreferences String
  Future<void> _q6SaveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('easy_q6_username', name);
    setState(() {
      _storedName = name;
    });
  }

  // Q7: SharedPreferences Counter
  Future<void> _q7IncrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final next = _prefCounter + 1;
    await prefs.setInt('easy_q7_counter', next);
    setState(() {
      _prefCounter = next;
    });
  }

  // Q8: In-Memory Cache Map
  void _q8FetchDataWithCache(String key) {
    if (_inMemoryCache.containsKey(key)) {
      setState(() {
        _cacheStatus = 'HIT: Retrieved from In-Memory Cache -> ${_inMemoryCache[key]}';
      });
    } else {
      // Simulate API fetch and cache store
      final mockData = 'API Response for "$key" (Fetched at ${DateTime.now().second}s)';
      _inMemoryCache[key] = mockData;
      setState(() {
        _cacheStatus = 'MISS: Fetched fresh from API & cached in Map -> $mockData';
      });
    }
  }

  // Q9: jsonEncode
  void _q9EncodeJson() {
    final studentMap = {
      'name': 'Vadgama Priya Ashokbhai',
      'roll_number': 35,
      'college': 'Atmiya University, Rajkot',
      'skills': ['Dart', 'Flutter', 'SQLite'],
    };
    final jsonStr = jsonEncode(studentMap);
    setState(() {
      _jsonEncodedResult = jsonStr;
    });
  }

  // Q10: jsonDecode
  void _q10DecodeJson() {
    const jsonStr = '{"course":"B.C.A. (C.S. & I.T.)","semester":5,"grade":"A","credits":24}';
    final Map<String, dynamic> decoded = jsonDecode(jsonStr);
    setState(() {
      _jsonDecodedResult = 'Decoded Map: Course=${decoded["course"]}, Sem=${decoded["semester"]}, Grade=${decoded["grade"]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod IV - Easy (Q1 to Q10)'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            title: 'Q1: getApplicationDocumentsDirectory()',
            content: Text('Path: $_docsPath', style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
            action: ElevatedButton.icon(
              onPressed: _q1GetDocsDir,
              icon: const Icon(Icons.folder_open),
              label: const Text('Resolve App Docs Directory'),
            ),
          ),
          _buildSectionCard(
            title: 'Q2–Q5: File CRUD (write, exists, read, delete)',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: $_fileStatus', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.indigo)),
                if (_fileReadContent.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey.shade100,
                    child: Text('Content: "$_fileReadContent"', style: const TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
              ],
            ),
            action: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(onPressed: _q2WriteFile, child: const Text('Q2: Write File')),
                ElevatedButton(onPressed: _q3Q4ReadFile, child: const Text('Q3/4: Check & Read')),
                ElevatedButton(
                  onPressed: _q5DeleteFile,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                  child: const Text('Q5: Delete File'),
                ),
              ],
            ),
          ),
          _buildSectionCard(
            title: 'Q6 & Q7: SharedPreferences (String & Counter)',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stored Username (Q6): $_storedName', style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Text('Persisted Counter (Q7): $_prefCounter', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            action: Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _q6SaveName('Vadgama Priya Ashokbhai (Updated)'),
                  child: const Text('Q6: Save Name'),
                ),
                ElevatedButton(
                  onPressed: _q7IncrementCounter,
                  child: const Text('Q7: Increment Counter'),
                ),
              ],
            ),
          ),
          _buildSectionCard(
            title: 'Q8: In-Memory Cache using Map',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_cacheStatus, style: const TextStyle(fontSize: 13)),
                Text('Cache Size: ${_inMemoryCache.length} keys', style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
            action: Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: () => _q8FetchDataWithCache('user_profile'), child: const Text('Request "user_profile"')),
                ElevatedButton(onPressed: () => _q8FetchDataWithCache('exam_results'), child: const Text('Request "exam_results"')),
                OutlinedButton(onPressed: () => setState(() => _inMemoryCache.clear()), child: const Text('Clear Memory Cache')),
              ],
            ),
          ),
          _buildSectionCard(
            title: 'Q9 & Q10: JSON Serialization (jsonEncode / jsonDecode)',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_jsonEncodedResult.isNotEmpty)
                  Text('Q9 jsonEncode:\n$_jsonEncodedResult', style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.teal)),
                const SizedBox(height: 6),
                if (_jsonDecodedResult.isNotEmpty)
                  Text('Q10 jsonDecode:\n$_jsonDecodedResult', style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.purple)),
              ],
            ),
            action: Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: _q9EncodeJson, child: const Text('Q9: jsonEncode()')),
                ElevatedButton(onPressed: _q10DecodeJson, child: const Text('Q10: jsonDecode()')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget content, required Widget action}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo)),
            const Divider(),
            content,
            const SizedBox(height: 12),
            action,
          ],
        ),
      ),
    );
  }
}
