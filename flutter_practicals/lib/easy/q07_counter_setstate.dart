import 'package:flutter/material.dart';

/// Easy Level - Practical 7:
/// Build a simple counter app using setState() with + and - buttons.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q07CounterSetStateScreen(),
  ));
}

class Q07CounterSetStateScreen extends StatefulWidget {
  const Q07CounterSetStateScreen({super.key});

  @override
  State<Q07CounterSetStateScreen> createState() => _Q07CounterSetStateScreenState();
}

class _Q07CounterSetStateScreenState extends State<Q07CounterSetStateScreen> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
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
        title: const Text('Easy Q7: Counter with setState()'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Counter Value',
              style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                  heroTag: 'decrement_btn',
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  onPressed: _decrement,
                  tooltip: 'Decrement (-)',
                  child: const Icon(Icons.remove, size: 36),
                ),
                const SizedBox(width: 24),
                IconButton.filledTonal(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reset',
                ),
                const SizedBox(width: 24),
                FloatingActionButton.large(
                  heroTag: 'increment_btn',
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  onPressed: _increment,
                  tooltip: 'Increment (+)',
                  child: const Icon(Icons.add, size: 36),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
