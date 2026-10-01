// Section B - Practical 10: Interactive ExpansionTile Accordion
// Build an interactive expandable FAQ / Settings accordion widget with smooth animation,
// custom leading/trailing indicators, and state handling.

import 'package:flutter/material.dart';

class SectionBQ10CustomExpansionAccordion extends StatefulWidget {
  const SectionBQ10CustomExpansionAccordion({super.key});

  @override
  State<SectionBQ10CustomExpansionAccordion> createState() => _SectionBQ10CustomExpansionAccordionState();
}

class _SectionBQ10CustomExpansionAccordionState extends State<SectionBQ10CustomExpansionAccordion> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'What is the role of StatefulWidget in Flutter?',
      'answer': 'A StatefulWidget possesses mutable state that persists across widget rebuilds. When setState() is invoked, the framework schedules the build() method to update the user interface.',
      'icon': Icons.sync,
      'isExpanded': true,
    },
    {
      'question': 'How does LayoutBuilder differ from MediaQuery?',
      'answer': 'MediaQuery provides top-level device window metrics (like overall screen width, padding, orientation). In contrast, LayoutBuilder provides local BoxConstraints from the parent widget, making widgets truly modular.',
      'icon': Icons.aspect_ratio,
      'isExpanded': false,
    },
    {
      'question': 'Why use Wrap over Row for dynamic chips and tags?',
      'answer': 'Row overflows horizontally with a RenderFlex error when items exceed the available viewport width. Wrap automatically flows child widgets onto subsequent lines without clipping.',
      'icon': Icons.wrap_text,
      'isExpanded': false,
    },
    {
      'question': 'How does Stack manage layered Z-Index rendering?',
      'answer': 'Stack renders children sequentially from bottom to top. Positioned widgets can precisely anchor badges, floating buttons, or avatars relative to the Stack bounds.',
      'icon': Icons.layers,
      'isExpanded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q10: Accordion ExpansionTile'),
        backgroundColor: Colors.teal.shade900,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final item = _faqs[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              initiallyExpanded: item['isExpanded'] as bool,
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade50,
                child: Icon(item['icon'] as IconData, color: Colors.teal.shade800),
              ),
              title: Text(
                item['question'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                  item['answer'] as String,
                  style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
