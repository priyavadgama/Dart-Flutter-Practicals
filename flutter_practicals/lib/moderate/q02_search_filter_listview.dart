import 'package:flutter/material.dart';

/// Moderate Level - Practical 2:
/// Add search-based filtering to a ListView.builder - typing in a TextField should filter the list.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q02SearchFilterListViewScreen(),
  ));
}

class Q02SearchFilterListViewScreen extends StatefulWidget {
  const Q02SearchFilterListViewScreen({super.key});

  @override
  State<Q02SearchFilterListViewScreen> createState() => _Q02SearchFilterListViewScreenState();
}

class _Q02SearchFilterListViewScreenState extends State<Q02SearchFilterListViewScreen> {
  final List<String> _allFrameworks = const [
    'Flutter & Dart',
    'React Native & JavaScript',
    'Swift & SwiftUI (iOS)',
    'Kotlin & Jetpack Compose (Android)',
    'Python & Django',
    'Node.js & Express',
    'Go (Golang)',
    'Rust Embedded',
    'Vue.js & Nuxt',
    'Angular & TypeScript',
    'TensorFlow & PyTorch',
    'Docker & Kubernetes',
  ];

  late List<String> _filteredList;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredList = List.from(_allFrameworks);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredList = List.from(_allFrameworks);
      } else {
        _filteredList = _allFrameworks
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q2: Search Filter List'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Input Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Technologies',
                hintText: 'Type keyword (e.g. Flutter, Swift, Python)...',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.teal.shade50.withValues(alpha: 0.5),
              ),
            ),
          ),
          // Results Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Found ${_filteredList.length} items',
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                if (_searchController.text.isNotEmpty)
                  Text(
                    'Query: "${_searchController.text}"',
                    style: const TextStyle(color: Colors.teal, fontStyle: FontStyle.italic),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Filtered ListView
          Expanded(
            child: _filteredList.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('No matching technologies found.', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
                          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
