// Section A - Practical 3: Scaffold, AppBar & FloatingActionButton
// Design a screen using Scaffold with an AppBar, a body Text, and a floating action button.

import 'package:flutter/material.dart';

class SectionAQ03ScaffoldAppBarFAB extends StatefulWidget {
  const SectionAQ03ScaffoldAppBarFAB({super.key});

  @override
  State<SectionAQ03ScaffoldAppBarFAB> createState() => _SectionAQ03ScaffoldAppBarFABState();
}

class _SectionAQ03ScaffoldAppBarFABState extends State<SectionAQ03ScaffoldAppBarFAB> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q3: Scaffold Structure'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demonstrating standard Flutter Scaffold structure')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.layers, size: 72, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text(
                'Scaffold Architecture Component',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 12),
              const Text(
                'This screen showcases the primary structural components of Flutter:\n• Top AppBar\n• Body Viewport\n• Floating Action Button',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Text(
                  'FAB Pressed: $_tapCount times',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _tapCount++;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Action button triggered! Total: $_tapCount'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.touch_app),
        label: const Text('Tap Action'),
      ),
    );
  }
}
