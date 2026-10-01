import 'package:flutter/material.dart';

/// Moderate Level - Practical 9:
/// Build a star rating widget (1 to 5 stars) that updates the selected rating using setState().

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q09StarRatingScreen(),
  ));
}

class Q09StarRatingScreen extends StatefulWidget {
  const Q09StarRatingScreen({super.key});

  @override
  State<Q09StarRatingScreen> createState() => _Q09StarRatingScreenState();
}

class _Q09StarRatingScreenState extends State<Q09StarRatingScreen> {
  int _currentRating = 3; // Default 3 stars

  final List<String> _ratingLabels = [
    'Please select a rating',
    'Poor 😞',
    'Fair 😐',
    'Good 🙂',
    'Very Good 😊',
    'Excellent! 🌟',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q9: Star Rating Widget'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rate Your Practical Session',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tap on any star to update your rating dynamically using setState().',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              // 5-Star interactive row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final isSelected = starIndex <= _currentRating;
                  return IconButton(
                    iconSize: 48,
                    icon: Icon(
                      isSelected ? Icons.star_rounded : Icons.star_border_rounded,
                      color: isSelected ? Colors.amber.shade700 : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentRating = starIndex;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),
              // Rating status card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      '$_currentRating / 5 Stars',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _ratingLabels[_currentRating],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Submit Rating'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Feedback Submitted: $_currentRating Stars (${_ratingLabels[_currentRating]})'),
                      backgroundColor: Colors.amber.shade900,
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
