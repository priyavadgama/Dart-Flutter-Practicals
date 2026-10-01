import 'package:flutter/material.dart';

/// Easy Level - Practical 1:
/// Create a `List<String>` of 10 fixed names and display them on screen using ListView.builder.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q01ListViewNamesScreen(),
  ));
}

class Q01ListViewNamesScreen extends StatelessWidget {
  const Q01ListViewNamesScreen({super.key});

  final List<String> names = const [
    'Vadgama Priya Ashokbhai',
    'Aarav Sharma',
    'Priya Patel',
    'Rohan Verma',
    'Ananya Iyer',
    'Kavya Nair',
    'Aditya Joshi',
    'Ishita Mehta',
    'Vikram Singh',
    'Neha Gupta',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Q1: ListView.builder Names'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  names[index],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
