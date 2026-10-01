// Section B - Practical 7: TabBar with Photos, Videos & Files
// Build a TabBar with three tabs (Photos, Videos, Files), each showing different placeholder content in a TabBarView.

import 'package:flutter/material.dart';

class SectionBQ07TabBarMediaViews extends StatelessWidget {
  const SectionBQ07TabBarMediaViews({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sec B - Q7: TabBar Media Views'),
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.amberAccent,
            indicatorWeight: 3,
            labelColor: Colors.amberAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.photo_library), text: 'Photos'),
              Tab(icon: Icon(Icons.video_library), text: 'Videos'),
              Tab(icon: Icon(Icons.folder_shared), text: 'Files'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _PhotosTabContent(),
            _VideosTabContent(),
            _FilesTabContent(),
          ],
        ),
      ),
    );
  }
}

class _PhotosTabContent extends StatelessWidget {
  const _PhotosTabContent();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, size: 48, color: Colors.teal.shade800),
              const SizedBox(height: 8),
              Text('IMG_2026_00${index + 1}.jpg', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade900, fontSize: 12)),
              Text('1920x1080 • ${(index + 1) * 1.2} MB', style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
        );
      },
    );
  }
}

class _VideosTabContent extends StatelessWidget {
  const _VideosTabContent();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.play_circle_fill, color: Colors.red, size: 32),
            ),
            title: Text('Lecture Video #0${index + 1}: Flutter State Management'),
            subtitle: Text('Duration: ${(index + 2) * 14} min • 1080p 60fps'),
            trailing: const Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}

class _FilesTabContent extends StatelessWidget {
  const _FilesTabContent();

  @override
  Widget build(BuildContext context) {
    final docs = [
      {'name': 'Dart_Module1_Assignment.pdf', 'size': '2.4 MB', 'ext': 'PDF', 'color': Colors.red},
      {'name': 'Flutter_Architecture_Notes.docx', 'size': '1.1 MB', 'ext': 'DOC', 'color': Colors.blue},
      {'name': 'Lab_Practical_Report_Roll35.zip', 'size': '18.5 MB', 'ext': 'ZIP', 'color': Colors.amber},
      {'name': 'Project_Wireframes_Figma.fig', 'size': '8.2 MB', 'ext': 'FIG', 'color': Colors.purple},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: docs.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final doc = docs[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: (doc['color'] as Color).withValues(alpha: 0.2),
            child: Text(doc['ext'] as String, style: TextStyle(color: doc['color'] as Color, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          title: Text(doc['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('File Size: ${doc['size']}'),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Downloading ${doc['name']}...')),
              );
            },
          ),
        );
      },
    );
  }
}
