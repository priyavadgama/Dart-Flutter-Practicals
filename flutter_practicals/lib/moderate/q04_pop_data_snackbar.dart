import 'package:flutter/material.dart';

/// Moderate Level - Practical 4:
/// Send data back from DetailScreen to HomeScreen using Navigator.pop(context, data)
/// and display it in a SnackBar.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q04PopDataHomeScreen(),
  ));
}

class Q04PopDataHomeScreen extends StatefulWidget {
  const Q04PopDataHomeScreen({super.key});

  @override
  State<Q04PopDataHomeScreen> createState() => _Q04PopDataHomeScreenState();
}

class _Q04PopDataHomeScreenState extends State<Q04PopDataHomeScreen> {
  String _returnedFeedback = 'No feedback received yet.';

  Future<void> _navigateAndGetFeedback(BuildContext context) async {
    // Navigator.push returns a Future that resolves with the value passed to Navigator.pop
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FeedbackDetailScreen()),
    );

    if (!mounted || !context.mounted) return;

    if (result != null) {
      setState(() {
        _returnedFeedback = result.toString();
      });

      // Display the returned data inside a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Received from DetailScreen: "$result"'),
          backgroundColor: Colors.teal.shade800,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q4: Return Data via pop()'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.feedback_outlined, size: 70, color: Colors.teal),
              const SizedBox(height: 20),
              const Text(
                'Awaiting Data from DetailScreen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Text(
                  _returnedFeedback,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Select Feedback Option'),
                onPressed: () => _navigateAndGetFeedback(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackDetailScreen extends StatelessWidget {
  const FeedbackDetailScreen({super.key});

  final List<String> options = const [
    'Outstanding Experience! ⭐⭐⭐⭐⭐',
    'Great Work & Clean UI! ⭐⭐⭐⭐',
    'Satisfactory Practical Execution ⭐⭐⭐',
    'Needs More Polish ⭐⭐',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen: Select Option'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(option, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.send, color: Colors.teal),
              onTap: () {
                // Passing the selected option back to HomeScreen
                Navigator.pop(context, option);
              },
            ),
          );
        },
      ),
    );
  }
}
