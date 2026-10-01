// Section B - Practical 2: Responsive Column vs Row with LayoutBuilder
// Create a responsive layout that shows a Column on mobile width and a Row on tablet/desktop width, using LayoutBuilder.

import 'package:flutter/material.dart';

class SectionBQ02ResponsiveColumnRow extends StatelessWidget {
  const SectionBQ02ResponsiveColumnRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q2: Responsive LayoutBuilder'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTabletOrDesktop = constraints.maxWidth >= 600;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isTabletOrDesktop ? Colors.green.shade50 : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isTabletOrDesktop ? Colors.green : Colors.blue),
                  ),
                  child: Row(
                    children: [
                      Icon(isTabletOrDesktop ? Icons.tablet_mac : Icons.phone_android,
                          color: isTabletOrDesktop ? Colors.green : Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Current Viewport Width: ${constraints.maxWidth.toStringAsFixed(1)} dp\n'
                          'Active Mode: ${isTabletOrDesktop ? "Tablet / Desktop (Row Layout)" : "Mobile (Column Layout)"}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isTabletOrDesktop ? Colors.green.shade900 : Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: isTabletOrDesktop
                      // Tablet/Desktop: Horizontal Row Layout
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _buildCard('Panel A: Analytics', Colors.indigo, Icons.bar_chart)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildCard('Panel B: System Log', Colors.deepPurple, Icons.terminal)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildCard('Panel C: User Profile', Colors.teal, Icons.badge)),
                          ],
                        )
                      // Mobile: Vertical Column Layout
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildCard('Panel A: Analytics', Colors.indigo, Icons.bar_chart, height: 160),
                              const SizedBox(height: 12),
                              _buildCard('Panel B: System Log', Colors.deepPurple, Icons.terminal, height: 160),
                              const SizedBox(height: 12),
                              _buildCard('Panel C: User Profile', Colors.teal, Icons.badge, height: 160),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, Color color, IconData icon, {double? height}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Adaptive LayoutBuilder element',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
