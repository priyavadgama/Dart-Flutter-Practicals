import 'package:flutter/material.dart';

/// Hard Level - Practical 5:
/// Create a layout where ListView.builder and GridView.builder can be toggled
/// on the same screen using a button (same data, different view).

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q05ToggleListGridScreen(),
  ));
}

class PhotoCardItem {
  final String title;
  final String category;
  final IconData icon;
  final Color color;

  const PhotoCardItem({
    required this.title,
    required this.category,
    required this.icon,
    required this.color,
  });
}

class Q05ToggleListGridScreen extends StatefulWidget {
  const Q05ToggleListGridScreen({super.key});

  @override
  State<Q05ToggleListGridScreen> createState() => _Q05ToggleListGridScreenState();
}

class _Q05ToggleListGridScreenState extends State<Q05ToggleListGridScreen> {
  bool _isGridView = false;

  final List<PhotoCardItem> items = const [
    PhotoCardItem(title: 'Flutter Framework', category: 'Mobile UI', icon: Icons.flutter_dash, color: Colors.blue),
    PhotoCardItem(title: 'Dart Language', category: 'Programming', icon: Icons.code, color: Colors.teal),
    PhotoCardItem(title: 'Firebase Suite', category: 'Backend & Cloud', icon: Icons.cloud, color: Colors.amber),
    PhotoCardItem(title: 'Provider Architecture', category: 'State Management', icon: Icons.layers, color: Colors.purple),
    PhotoCardItem(title: 'Riverpod Library', category: 'Reactive State', icon: Icons.stream, color: Colors.indigo),
    PhotoCardItem(title: 'Bloc Pattern', category: 'Event Architecture', icon: Icons.architecture, color: Colors.deepOrange),
    PhotoCardItem(title: 'Material 3 Design', category: 'Design System', icon: Icons.style, color: Colors.pink),
    PhotoCardItem(title: 'CI/CD Pipelines', category: 'DevOps & Test', icon: Icons.sync, color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard Q5: Toggle List / Grid'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: _isGridView ? 'Switch to List View' : 'Switch to Grid View',
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.indigo.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current View: ${_isGridView ? "GridView.builder (2 Columns)" : "ListView.builder"}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                TextButton.icon(
                  icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view, size: 18),
                  label: Text(_isGridView ? 'List Mode' : 'Grid Mode'),
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isGridView ? _buildGridView() : _buildListView(),
            ),
          ),
        ],
      ),
    );
  }

  // 1. ListView.builder Layout
  Widget _buildListView() {
    return ListView.builder(
      key: const ValueKey('list_view'),
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: item.color,
              child: Icon(item.icon, color: Colors.white),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.category),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ),
        );
      },
    );
  }

  // 2. GridView.builder Layout
  Widget _buildGridView() {
    return GridView.builder(
      key: const ValueKey('grid_view'),
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: item.color,
                  child: Icon(item.icon, size: 28, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
