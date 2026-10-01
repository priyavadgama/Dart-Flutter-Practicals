// Section A - Practical 2: Counter App using StatefulWidget
// Build a simple counter app using a StatefulWidget with Increment and Decrement buttons.

import 'package:flutter/material.dart';

class SectionAQ02CounterStateful extends StatefulWidget {
  const SectionAQ02CounterStateful({super.key});

  @override
  State<SectionAQ02CounterStateful> createState() => _SectionAQ02CounterStatefulState();
}

class _SectionAQ02CounterStatefulState extends State<SectionAQ02CounterStateful> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec A - Q2: Counter StatefulWidget'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Current Counter Value',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.teal, width: 3),
                ),
                child: Center(
                  child: Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'dec_btn',
                    onPressed: _decrement,
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  const SizedBox(width: 24),
                  FloatingActionButton(
                    heroTag: 'reset_btn',
                    onPressed: _reset,
                    backgroundColor: Colors.grey,
                    child: const Icon(Icons.refresh, color: Colors.white),
                  ),
                  const SizedBox(width: 24),
                  FloatingActionButton(
                    heroTag: 'inc_btn',
                    onPressed: _increment,
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'State managed via setState() in StatefulWidget',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
