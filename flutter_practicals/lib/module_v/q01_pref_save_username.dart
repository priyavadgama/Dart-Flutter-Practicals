// Module V - Practical 1: Save & Display Username via SharedPreferences
// Create a Flutter app that saves a username using Shared Preferences and displays it after the app restarts.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleVQ01PrefSaveUsername extends StatefulWidget {
  const ModuleVQ01PrefSaveUsername({super.key});

  @override
  State<ModuleVQ01PrefSaveUsername> createState() => _ModuleVQ01PrefSaveUsernameState();
}

class _ModuleVQ01PrefSaveUsernameState extends State<ModuleVQ01PrefSaveUsername> {
  static const String _prefKey = 'saved_username_v1';
  final TextEditingController _usernameController = TextEditingController();
  String? _persistedUsername;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedUsername();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _persistedUsername = prefs.getString(_prefKey) ?? 'Vadgama Priya Ashokbhai (Default)';
      _isLoading = false;
    });
  }

  Future<void> _saveUsername() async {
    final text = _usernameController.text.trim();
    if (text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, text);

    setState(() {
      _persistedUsername = text;
      _usernameController.clear();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved "$text" to SharedPreferences!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _clearUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefKey);
    setState(() {
      _persistedUsername = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q1: SharedPreferences Username'),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.account_circle, size: 64, color: Colors.teal),
                        const SizedBox(height: 12),
                        const Text('Stored in SharedPreferences:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 6),
                        Text(
                          _persistedUsername ?? 'No username stored yet',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: _persistedUsername != null ? Colors.teal.shade900 : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Enter New Username',
                      hintText: 'e.g. Vadgama Priya Ashokbhai (Roll 35)',
                      prefixIcon: const Icon(Icons.edit),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _saveUsername,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('Save to SharedPreferences', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: _clearUsername,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text('Clear Saved Data', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
    );
  }
}
