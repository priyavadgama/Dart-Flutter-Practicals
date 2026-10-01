import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 9:
/// Design a settings screen with grouped sections using nested Column and
/// Table widgets, where the layout gracefully reflows into two columns
/// when width exceeds 700 dp.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q09ReflowingSettingsScreen(),
  ));
}

class Q09ReflowingSettingsScreen extends StatefulWidget {
  const Q09ReflowingSettingsScreen({super.key});

  @override
  State<Q09ReflowingSettingsScreen> createState() => _Q09ReflowingSettingsScreenState();
}

class _Q09ReflowingSettingsScreenState extends State<Q09ReflowingSettingsScreen> {
  bool _emailNotifs = true;
  bool _smsAlerts = false;
  bool _twoFactorAuth = true;
  bool _biometrics = true;
  bool _autoUpdates = true;
  bool _analyticsShare = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section C Q9: Reflowing Settings Screen'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Layout Width: ${constraints.maxWidth.toStringAsFixed(0)} dp • Mode: ${isWide ? "Two-Column Reflow (>= 700dp)" : "Single-Column Stack (< 700dp)"}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ),
                const SizedBox(height: 20),
                if (isWide)
                  // Two columns side-by-side
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildAccountSection(),
                            const SizedBox(height: 20),
                            _buildSecurityTableSection(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            _buildNotificationSection(),
                            const SizedBox(height: 20),
                            _buildSystemPreferencesSection(),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  // Single column stacked
                  Column(
                    children: [
                      _buildAccountSection(),
                      const SizedBox(height: 20),
                      _buildSecurityTableSection(),
                      const SizedBox(height: 20),
                      _buildNotificationSection(),
                      const SizedBox(height: 20),
                      _buildSystemPreferencesSection(),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Section 1: Account Info using Table widget
  Widget _buildAccountSection() {
    return _sectionCard(
      title: 'Profile & Account Details',
      icon: Icons.person_outline,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(2.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: const [
          TableRow(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('User Name:', style: TextStyle(fontWeight: FontWeight.bold))),
              Text('Vadgama Priya Ashokbhai'),
            ],
          ),
          TableRow(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Roll Number:', style: TextStyle(fontWeight: FontWeight.bold))),
              Text('35 (B.C.A. (C.S. & I.T.))'),
            ],
          ),
          TableRow(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Account Tier:', style: TextStyle(fontWeight: FontWeight.bold))),
              Text('Verified Developer Pro'),
            ],
          ),
        ],
      ),
    );
  }

  // Section 2: Security & Permissions using Table widget
  Widget _buildSecurityTableSection() {
    return _sectionCard(
      title: 'Privacy & Security Matrix',
      icon: Icons.security,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            children: const [
              Padding(padding: EdgeInsets.all(8.0), child: Text('Security Feature', style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('Status & Toggle', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          TableRow(
            children: [
              const Padding(padding: EdgeInsets.all(8.0), child: Text('Two-Factor Authentication (2FA)')),
              Switch(
                value: _twoFactorAuth,
                onChanged: (val) => setState(() => _twoFactorAuth = val),
              ),
            ],
          ),
          TableRow(
            children: [
              const Padding(padding: EdgeInsets.all(8.0), child: Text('Biometric Fingerprint / Face Unlock')),
              Switch(
                value: _biometrics,
                onChanged: (val) => setState(() => _biometrics = val),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section 3: Notification Settings using Column
  Widget _buildNotificationSection() {
    return _sectionCard(
      title: 'Alerts & Notifications',
      icon: Icons.notifications_none,
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Email Notifications'),
            subtitle: const Text('Lab schedules, exam alerts, grades'),
            value: _emailNotifs,
            onChanged: (val) => setState(() => _emailNotifs = val),
          ),
          const Divider(height: 1),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('SMS Push Alerts'),
            subtitle: const Text('Critical security warnings'),
            value: _smsAlerts,
            onChanged: (val) => setState(() => _smsAlerts = val),
          ),
        ],
      ),
    );
  }

  // Section 4: System Preferences using Column and Table
  Widget _buildSystemPreferencesSection() {
    return _sectionCard(
      title: 'Device & Engine Diagnostics',
      icon: Icons.tune,
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Automatic Flutter Updates'),
            subtitle: const Text('Keep frameworks on latest stable channels'),
            value: _autoUpdates,
            onChanged: (val) => setState(() => _autoUpdates = val),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Share Diagnostic Telemetry'),
            subtitle: const Text('Help improve compiler benchmarks'),
            value: _analyticsShare,
            onChanged: (val) => setState(() => _analyticsShare = val),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required IconData icon, required Widget child}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.indigo, size: 24),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}
