// Module V - Practical 10: Local File I/O with path_provider
// Create a Flutter app that reads and writes text to a local file using File Storage (path_provider).

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ModuleVQ10FileStoragePathProvider extends StatefulWidget {
  const ModuleVQ10FileStoragePathProvider({super.key});

  @override
  State<ModuleVQ10FileStoragePathProvider> createState() => _ModuleVQ10FileStoragePathProviderState();
}

class _ModuleVQ10FileStoragePathProviderState extends State<ModuleVQ10FileStoragePathProvider> {
  final TextEditingController _inputController = TextEditingController();
  String _fileContent = '';
  String _filePath = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAndReadFile();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/student_notes_roll35.txt';
    setState(() {
      _filePath = path;
    });
    return File(path);
  }

  Future<void> _initAndReadFile() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _fileContent = content;
          _isLoading = false;
        });
      } else {
        // Write initial default content
        const defaultText = 'Initial file created by Vadgama Priya Ashokbhai (Roll No: 35).\nFlutter path_provider local disk storage demo.';
        await file.writeAsString(defaultText);
        setState(() {
          _fileContent = defaultText;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _fileContent = 'Error reading file: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _writeToFile() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    try {
      final file = await _getLocalFile();
      await file.writeAsString(text);
      setState(() {
        _fileContent = text;
        _inputController.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved to file successfully!'), backgroundColor: Colors.indigo),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Write error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _appendToFile() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    try {
      final file = await _getLocalFile();
      await file.writeAsString('\n[${DateTime.now().toIso8601String().substring(11, 19)}] $text', mode: FileMode.append);
      final updated = await file.readAsString();
      setState(() {
        _fileContent = updated;
        _inputController.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appended text to local file!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Append error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q10: File Storage (path_provider)'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.folder, color: Colors.indigo),
                            SizedBox(width: 8),
                            Text('Resolved Documents Directory:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.indigo)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(_filePath, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.black87)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Live File Contents (readAsString):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const Divider(),
                          Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(minHeight: 100),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _fileContent.isEmpty ? '(File is empty)' : _fileContent,
                              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _inputController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Text to Write or Append',
                      hintText: 'Enter text here...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _writeToFile,
                          icon: const Icon(Icons.edit),
                          label: const Text('Overwrite File'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade800, foregroundColor: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _appendToFile,
                          icon: const Icon(Icons.add),
                          label: const Text('Append to File'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700, foregroundColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
