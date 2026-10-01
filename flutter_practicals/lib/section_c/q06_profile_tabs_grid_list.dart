import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 6:
/// Design a custom multi-tab profile screen combining TabBar, GridView
/// (for a photo grid tab), and ListView (for an activity feed tab) inside a single Scaffold.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q06ProfileTabsScreen(),
  ));
}

class Q06ProfileTabsScreen extends StatelessWidget {
  const Q06ProfileTabsScreen({super.key});

  final List<Color> photoColors = const [
    Colors.deepPurple,
    Colors.blue,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
    Colors.pink,
    Colors.orange,
    Colors.cyan,
    Colors.green,
  ];

  final List<Map<String, String>> activities = const [
    {'title': 'Uploaded new project repository', 'time': '20 mins ago', 'type': 'code'},
    {'title': 'Earned Flutter Certified Developer Badge', 'time': '2 hours ago', 'type': 'badge'},
    {'title': 'Submitted Practical Lab Assessment', 'time': 'Yesterday', 'type': 'assignment'},
    {'title': 'Commented on State Management discussion', 'time': '3 days ago', 'type': 'comment'},
    {'title': 'Attended Google I/O Extended Conference', 'time': '5 days ago', 'type': 'event'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade900, Colors.deepPurple.shade700],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.indigo,
                            child: Icon(Icons.person, size: 50, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Vadgama Priya Ashokbhai',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Flutter & Dart Software Developer | Roll No: 35',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.amberAccent,
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on), text: 'Photo Gallery (GridView)'),
                    Tab(icon: Icon(Icons.timeline), text: 'Activity Feed (ListView)'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              // ================= TAB 1: GRIDVIEW FOR PHOTOS =================
              GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: photoColors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: photoColors[index].withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 36,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  );
                },
              ),
              // ================= TAB 2: LISTVIEW FOR ACTIVITY FEED =================
              ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final act = activities[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade50,
                        child: const Icon(Icons.history, color: Colors.indigo),
                      ),
                      title: Text(act['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(act['time']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
