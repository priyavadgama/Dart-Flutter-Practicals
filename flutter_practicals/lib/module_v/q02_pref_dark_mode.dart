// Module V - Practical 2: Dark Mode Switch with SharedPreferences
// Create a Flutter app with a switch to save and load a "Dark Mode" setting using Shared Preferences.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleVQ02PrefDarkMode extends StatefulWidget {
  const ModuleVQ02PrefDarkMode({super.key});

  @override
  State<ModuleVQ02PrefDarkMode> createState() => _ModuleVQ02PrefDarkModeState();
}

class _ModuleVQ02PrefDarkModeState extends State<ModuleVQ02PrefDarkMode> {
  static const String _themePrefKey = 'is_dark_mode_enabled';
  bool _isDarkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadThemeSetting();
  }

  Future<void> _loadThemeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool(_themePrefKey) ?? false;
      _isLoading = false;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefKey, value);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isDarkMode ? 'Dark Mode saved & activated!' : 'Light Mode saved & activated!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final cardColor = _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black87;

    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('Mod V - Q2: Dark Mode Preference'),
          backgroundColor: _isDarkMode ? Colors.black : Colors.blueGrey.shade800,
          foregroundColor: Colors.white,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _isDarkMode ? Colors.black45 : Colors.black12,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          size: 72,
                          color: _isDarkMode ? Colors.amberAccent : Colors.orange,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _isDarkMode ? 'Dark Theme Active' : 'Light Theme Active',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Preference is persisted in SharedPreferences and preserved across app reboots.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: textColor.withValues(alpha: 0.7)),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enable Dark Mode',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
                            ),
                            Switch(
                              value: _isDarkMode,
                              onChanged: _toggleDarkMode,
                              activeThumbColor: Colors.amberAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
