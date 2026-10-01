import 'package:flutter/material.dart';

/// Easy Level - Practical 3:
/// Create a List of 6 colors and display colored boxes in 2 columns using GridView.builder.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q03GridViewColoredBoxesScreen(),
  ));
}

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class Q03GridViewColoredBoxesScreen extends StatelessWidget {
  const Q03GridViewColoredBoxesScreen({super.key});

  final List<NamedColor> colorsList = const [
    NamedColor('Deep Amber', Colors.amber),
    NamedColor('Royal Purple', Colors.purple),
    NamedColor('Crimson Red', Colors.redAccent),
    NamedColor('Emerald Green', Colors.green),
    NamedColor('Ocean Cyan', Colors.cyan),
    NamedColor('Deep Orange', Colors.deepOrange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Q3: GridView 2 Columns'),
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: colorsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = colorsList[index];
            return Container(
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: item.color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.palette, color: Colors.white, size: 36),
                  const SizedBox(height: 8),
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Color ${index + 1}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
