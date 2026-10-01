// Module V - Practical 9: Store & Display Name and Age using Hive
// Create a Flutter app that uses Hive to store and display a user's name and age together.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ModuleVQ09HiveUserNameAge extends StatefulWidget {
  const ModuleVQ09HiveUserNameAge({super.key});

  @override
  State<ModuleVQ09HiveUserNameAge> createState() => _ModuleVQ09HiveUserNameAgeState();
}

class _ModuleVQ09HiveUserNameAgeState extends State<ModuleVQ09HiveUserNameAge> {
  Box? _userBox;
  final TextEditingController _nameController = TextEditingController(text: 'Vadgama Priya Ashokbhai');
  final TextEditingController _ageController = TextEditingController(text: '20');
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initHiveUserBox();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _initHiveUserBox() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox('user_profile_box_roll35');

    if (!_userBox!.containsKey('profile')) {
      await _userBox!.put('profile', {
        'name': 'Vadgama Priya Ashokbhai',
        'age': 20,
        'roll': 35,
      });
    }

    setState(() {
      _isReady = true;
    });
  }

  Future<void> _saveUserProfile() async {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    if (name.isEmpty || age <= 0 || _userBox == null) return;

    // Store compound Map object in Hive box
    await _userBox!.put('profile', {
      'name': name,
      'age': age,
      'roll': 35,
      'updatedAt': DateTime.now().toIso8601String().substring(11, 19),
    });

    setState(() {});

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hive updated: Name "$name", Age $age'), backgroundColor: Colors.teal),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final rawProfile = _userBox?.get('profile');
    final Map<dynamic, dynamic> profile = (rawProfile is Map) ? rawProfile : {};

    final currentName = profile['name']?.toString() ?? 'Not Set';
    final currentAge = profile['age']?.toString() ?? 'Not Set';
    final lastUpdated = profile['updatedAt']?.toString() ?? 'Initial seed';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mod V - Q9: Hive Name & Age'),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: !_isReady
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.teal.shade300),
                    ),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          currentName,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal.shade900),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Age: $currentAge years old',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        Text('Hive Box Key: "profile" • Updated: $lastUpdated', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Update Stored Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: 'User Name', prefixIcon: Icon(Icons.badge)),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _ageController,
                            decoration: const InputDecoration(labelText: 'User Age', prefixIcon: Icon(Icons.calendar_today)),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _saveUserProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade800,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: const Icon(Icons.save),
                              label: const Text('Commit to Hive Storage'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
