import 'package:flutter/material.dart';

/// Hard Level - Practical 8:
/// Pattern printing: take user input N and dynamically generate and display
/// a pyramid pattern (of numbers) using a GridView or Column.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q08NumberPyramidScreen(),
  ));
}

class Q08NumberPyramidScreen extends StatefulWidget {
  const Q08NumberPyramidScreen({super.key});

  @override
  State<Q08NumberPyramidScreen> createState() => _Q08NumberPyramidScreenState();
}

class _Q08NumberPyramidScreenState extends State<Q08NumberPyramidScreen> {
  final TextEditingController _numberController = TextEditingController(text: '5');
  int _levels = 5;

  void _updatePyramid() {
    final parsed = int.tryParse(_numberController.text.trim());
    if (parsed != null && parsed >= 1 && parsed <= 12) {
      setState(() {
        _levels = parsed;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an integer between 1 and 12')),
      );
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard Q8: Dynamic Number Pyramid'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Pyramid Depth (N)',
                      hintText: 'Enter 1 to 12',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.change_history),
                    ),
                    onSubmitted: (_) => _updatePyramid(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  icon: const Icon(Icons.account_tree_outlined),
                  label: const Text('Render Pyramid'),
                  onPressed: _updatePyramid,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_levels, (rowIndex) {
                          final currentLevel = rowIndex + 1;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Ascending numbers: 1 to currentLevel
                                for (int i = 1; i <= currentLevel; i++)
                                  _pyramidCell('$i', Colors.amberAccent),
                                // Descending numbers: currentLevel - 1 down to 1
                                for (int i = currentLevel - 1; i >= 1; i--)
                                  _pyramidCell('$i', Colors.orangeAccent),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pyramidCell(String text, Color color) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
