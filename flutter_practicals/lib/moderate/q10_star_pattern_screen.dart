import 'package:flutter/material.dart';

/// Moderate Level - Practical 10:
/// Create a Flutter screen that prints a '*' pattern - entering a number
/// in a TextField should display that many rows of stars (using setState()).

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q10StarPatternScreen(),
  ));
}

class Q10StarPatternScreen extends StatefulWidget {
  const Q10StarPatternScreen({super.key});

  @override
  State<Q10StarPatternScreen> createState() => _Q10StarPatternScreenState();
}

class _Q10StarPatternScreenState extends State<Q10StarPatternScreen> {
  final TextEditingController _rowsController = TextEditingController(text: '5');
  List<String> _patternRows = [];

  @override
  void initState() {
    super.initState();
    _generatePattern(5);
  }

  void _generatePattern(int rowCount) {
    List<String> rows = [];
    for (int i = 1; i <= rowCount; i++) {
      rows.add('* ' * i);
    }
    setState(() {
      _patternRows = rows;
    });
  }

  void _onGeneratePressed() {
    final input = _rowsController.text.trim();
    final count = int.tryParse(input);
    if (count != null && count > 0 && count <= 50) {
      _generatePattern(count);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number between 1 and 50')),
      );
    }
  }

  @override
  void dispose() {
    _rowsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q10: Dynamic Star Pattern'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _rowsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Number of Rows (N)',
                      hintText: 'e.g. 5, 8, 10',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.format_list_numbered),
                    ),
                    onSubmitted: (_) => _onGeneratePressed(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Render'),
                  onPressed: _onGeneratePressed,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Generated Pattern for ${_patternRows.length} Rows:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                  ],
                ),
                child: ListView.builder(
                  itemCount: _patternRows.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        '${(index + 1).toString().padLeft(2, ' ')} | ${_patternRows[index]}',
                        style: const TextStyle(
                          color: Colors.amberAccent,
                          fontFamily: 'monospace',
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
