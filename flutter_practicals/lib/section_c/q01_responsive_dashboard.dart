import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 1:
/// Build a complete responsive dashboard screen that displays a single-column
/// list on mobile, a two-column grid on tablets, and a three-panel Row layout
/// (sidebar, content, details) on desktop width, using LayoutBuilder and MediaQuery together.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q01ResponsiveDashboardScreen(),
  ));
}

class DashboardItem {
  final String title;
  final String metric;
  final String change;
  final IconData icon;
  final Color color;

  const DashboardItem(this.title, this.metric, this.change, this.icon, this.color);
}

class Q01ResponsiveDashboardScreen extends StatelessWidget {
  const Q01ResponsiveDashboardScreen({super.key});

  final List<DashboardItem> stats = const [
    DashboardItem('Total Students', '1,420', '+12% this month', Icons.people, Colors.blue),
    DashboardItem('Practicals Submitted', '8,950', '+24% this week', Icons.assignment_turned_in, Colors.green),
    DashboardItem('Active Lab Servers', '42 / 45', '98.5% Uptime', Icons.storage, Colors.purple),
    DashboardItem('Average Performance', '86.4%', '+4.2% overall', Icons.trending_up, Colors.orange),
    DashboardItem('Code Commits', '2,340', 'Last push 5m ago', Icons.commit, Colors.indigo),
    DashboardItem('Bug Reports', '7 Open', '-50% resolved', Icons.bug_report, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Section C Q1: Responsive Dashboard (${orientation.name})'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (width >= 1000) {
            // Desktop width: 3-panel Row layout (sidebar, content, details)
            return _buildDesktopLayout();
          } else if (width >= 600) {
            // Tablet width: 2-column grid
            return _buildTabletLayout();
          } else {
            // Mobile width: Single-column list
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  // 1. Mobile Layout (< 600 dp)
  Widget _buildMobileLayout() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final item = stats[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: item.color.withValues(alpha: 0.2),
              child: Icon(item.icon, color: item.color),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.change),
            trailing: Text(item.metric, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: item.color)),
          ),
        );
      },
    );
  }

  // 2. Tablet Layout (600 dp - 1000 dp)
  Widget _buildTabletLayout() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) {
        final item = stats[index];
        return Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: item.color.withValues(alpha: 0.2),
                  child: Icon(item.icon, size: 28, color: item.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(item.metric, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: item.color)),
                      Text(item.change, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 3. Desktop Layout (>= 1000 dp)
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left Panel: Sidebar
        Container(
          width: 240,
          color: Colors.indigo.shade900,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              Text('PORTAL ADMIN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Divider(color: Colors.white24, height: 32),
              ListTile(leading: Icon(Icons.dashboard, color: Colors.white), title: Text('Overview', style: TextStyle(color: Colors.white))),
              ListTile(leading: Icon(Icons.assessment, color: Colors.white70), title: Text('Practicals', style: TextStyle(color: Colors.white70))),
              ListTile(leading: Icon(Icons.people, color: Colors.white70), title: Text('Students', style: TextStyle(color: Colors.white70))),
              ListTile(leading: Icon(Icons.settings, color: Colors.white70), title: Text('Preferences', style: TextStyle(color: Colors.white70))),
            ],
          ),
        ),
        // Center Panel: Main Grid Content
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dashboard Metrics (Desktop View)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    itemCount: stats.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (context, index) {
                      final item = stats[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(item.icon, color: item.color, size: 32),
                              Text(item.title, style: const TextStyle(color: Colors.grey)),
                              Text(item.metric, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: item.color)),
                              Text(item.change, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Panel: Details / Activity Feed
        Container(
          width: 280,
          color: Colors.grey.shade100,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recent Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(height: 24),
              const ListTile(
                dense: true,
                leading: Icon(Icons.check, color: Colors.green),
                title: Text('Vadgama Priya Ashokbhai submitted Practical 13-24'),
                subtitle: Text('2 minutes ago'),
              ),
              const ListTile(
                dense: true,
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Grade A+ awarded for Flutter UI'),
                subtitle: Text('10 minutes ago'),
              ),
              const ListTile(
                dense: true,
                leading: Icon(Icons.cloud_done, color: Colors.blue),
                title: Text('Repository synced successfully'),
                subtitle: Text('1 hour ago'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
