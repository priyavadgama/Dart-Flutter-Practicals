// Section B - Practical 8: Settings Screen with Table Widget
// Create a settings screen using a Table widget to display label-value pairs in aligned rows and columns.

import 'package:flutter/material.dart';

class SectionBQ08SettingsTableWidget extends StatelessWidget {
  const SectionBQ08SettingsTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q8: Table Widget Settings'),
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System & Application Configurations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Implemented using Flutter’s native Table widget with explicit column widths and borders.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Native Table Widget
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
                width: 1,
                borderRadius: BorderRadius.circular(12),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2.0), // Label column
                1: FlexColumnWidth(2.5), // Value column
                2: FlexColumnWidth(1.2), // Status / Action column
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                // Header Row
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  children: const [
                    _TableHeaderCell('Configuration Parameter'),
                    _TableHeaderCell('Current Value'),
                    _TableHeaderCell('Status'),
                  ],
                ),

                // Data Rows
                _buildTableRow('Student Name', 'Vadgama Priya Ashokbhai', 'Verified', Colors.green),
                _buildTableRow('Roll Number', '35', 'Active', Colors.green),
                _buildTableRow('Institution', 'Atmiya University, Rajkot', 'Confirmed', Colors.green),
                _buildTableRow('Flutter SDK', '3.38.1 Stable', 'Latest', Colors.blue),
                _buildTableRow('Dart Version', '3.12.1', 'Up-to-date', Colors.blue),
                _buildTableRow('Offline Cache Mode', 'Enabled (50 MB limit)', 'Active', Colors.green),
                _buildTableRow('Biometric Login', 'Fingerprint / Face ID', 'Configured', Colors.purple),
                _buildTableRow('Theme Mode', 'System Default (Adaptive)', 'Ready', Colors.orange),
                _buildTableRow('Data Sync Interval', 'Every 15 Minutes', 'Idle', Colors.blueGrey),
                _buildTableRow('Cloud Backup', 'Auto-Sync to Google Drive', 'Running', Colors.teal),
              ],
            ),

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.table_chart, color: Colors.blueGrey),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Table widget ensures rigid column alignment across devices without layout jitter.',
                      style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static TableRow _buildTableRow(String param, String val, String status, Color statusColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Text(param, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Text(val, style: const TextStyle(color: Colors.black87, fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
      ),
    );
  }
}
