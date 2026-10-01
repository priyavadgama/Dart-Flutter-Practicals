import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 7:
/// Build a card-based news feed screen where each Card uses IntrinsicHeight
/// to align an image and text side by side with matching heights, and the whole
/// feed loads through ListView.builder.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q07IntrinsicHeightNewsFeedScreen(),
  ));
}

class NewsArticle {
  final String headline;
  final String summary;
  final String category;
  final String time;
  final IconData imageIcon;
  final Color themeColor;

  const NewsArticle({
    required this.headline,
    required this.summary,
    required this.category,
    required this.time,
    required this.imageIcon,
    required this.themeColor,
  });
}

class Q07IntrinsicHeightNewsFeedScreen extends StatelessWidget {
  const Q07IntrinsicHeightNewsFeedScreen({super.key});

  final List<NewsArticle> articles = const [
    NewsArticle(
      headline: 'Flutter 3.44 Unleashes Groundbreaking Cross-Platform Graphics and Impeller Upgrades',
      summary:
          'The Flutter team announced extensive performance enhancements with zero junk shader compilation, instant frame rendering, and enhanced Material 3 accessibility benchmarks.',
      category: 'Tech News',
      time: '15 mins ago',
      imageIcon: Icons.flutter_dash,
      themeColor: Colors.blue,
    ),
    NewsArticle(
      headline: 'AI Agents Transform Mobile Application Development Workflows',
      summary:
          'DeepMind and leading developers demonstrate automated pair-programming, multi-agent collaboration, and instant bug resolution in modern software ecosystems.',
      category: 'Artificial Intelligence',
      time: '1 hour ago',
      imageIcon: Icons.psychology,
      themeColor: Colors.deepPurple,
    ),
    NewsArticle(
      headline: 'Dart 3.12 Brings Enhanced Pattern Matching and FFI Native Assets Integration',
      summary:
          'With expanded type safety and streamlined native bindings, developers can compile C/C++ libraries seamlessly without boilerplate code.',
      category: 'Software Architecture',
      time: '3 hours ago',
      imageIcon: Icons.code,
      themeColor: Colors.teal,
    ),
    NewsArticle(
      headline: 'Clean Code Standards and Architecture Patterns for Flutter Enterprise Apps',
      summary:
          'Industry survey underscores the importance of feature-first folder structures, strict unit test coverage, and reactive state management.',
      category: 'Best Practices',
      time: 'Yesterday',
      imageIcon: Icons.verified_user,
      themeColor: Colors.amber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section C Q7: IntrinsicHeight News Feed'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            // IntrinsicHeight forces all children of the Row to match the height of the tallest child!
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Expands image to match text column height
                children: [
                  // Image representation matching the text's dynamic height
                  Container(
                    width: 110,
                    color: article.themeColor.withValues(alpha: 0.15),
                    child: Center(
                      child: Icon(article.imageIcon, size: 54, color: article.themeColor),
                    ),
                  ),
                  // Text information column
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: article.themeColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  article.category,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: article.themeColor,
                                  ),
                                ),
                              ),
                              Text(article.time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            article.headline,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, height: 1.2),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            article.summary,
                            style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
