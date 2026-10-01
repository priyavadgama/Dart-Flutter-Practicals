// Section B - Practical 5: Skill/Tag Selector with Wrap Widget
// Create a tag/skill selector screen using the Wrap widget where tapped Chips toggle a selected state.

import 'package:flutter/material.dart';

class SectionBQ05SkillTagWrapChips extends StatefulWidget {
  const SectionBQ05SkillTagWrapChips({super.key});

  @override
  State<SectionBQ05SkillTagWrapChips> createState() => _SectionBQ05SkillTagWrapChipsState();
}

class _SectionBQ05SkillTagWrapChipsState extends State<SectionBQ05SkillTagWrapChips> {
  final List<String> _allSkills = [
    'Flutter',
    'Dart',
    'State Management',
    'Provider',
    'Riverpod',
    'BLoC',
    'SQLite',
    'Hive',
    'Firebase',
    'REST APIs',
    'Git & GitHub',
    'Docker',
    'CI/CD Pipelines',
    'UI/UX Design',
    'Unit Testing',
  ];

  final Set<String> _selectedSkills = {
    'Flutter',
    'Dart',
    'Provider',
    'Riverpod',
  };

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q5: Wrap & FilterChips'),
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Technical Competencies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tap any skill chip to toggle its selected state. Layout dynamically wraps across lines.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Wrap Widget Implementation
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _allSkills.map((skill) {
                final isSelected = _selectedSkills.contains(skill);
                return FilterChip(
                  label: Text(skill),
                  selected: isSelected,
                  selectedColor: Colors.teal.shade100,
                  checkmarkColor: Colors.teal.shade900,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.teal.shade900 : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  avatar: isSelected
                      ? null
                      : const Icon(Icons.code, size: 16, color: Colors.grey),
                  onSelected: (_) => _toggleSkill(skill),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Skills (${_selectedSkills.length})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                TextButton(
                  onPressed: () => setState(() => _selectedSkills.clear()),
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: _selectedSkills.isEmpty
                  ? const Text('No skills currently selected. Tap the chips above!', style: TextStyle(color: Colors.grey))
                  : Text(
                      _selectedSkills.join(', '),
                      style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.w600, height: 1.4),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
