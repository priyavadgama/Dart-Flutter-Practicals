import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Easy Level - Practical 10:
/// Create a small Provider example with two separate buttons showing the
/// difference between context.read() and context.watch().

class ClickCountNotifier extends ChangeNotifier {
  int _clicks = 0;

  int get clicks => _clicks;

  void addClick() {
    _clicks++;
    notifyListeners();
  }

  void reset() {
    _clicks = 0;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ClickCountNotifier(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Q10ReadVsWatchScreen(),
      ),
    ),
  );
}

class Q10ReadVsWatchScreen extends StatelessWidget {
  const Q10ReadVsWatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClickCountNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Easy Q10: context.read vs watch'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Understanding Provider Access APIs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• context.watch<T>(): Subscribes the widget to changes. When notifyListeners() is called, this widget rebuilds.\n'
                '• context.read<T>(): Reads the model once without subscribing. Ideal inside event callbacks (onPressed) to avoid redundant rebuilds.',
                style: TextStyle(color: Colors.black87, height: 1.4),
              ),
              Divider(height: 32),
              // Subscribed widget using context.watch()
              WatchDisplayWidget(),
              SizedBox(height: 24),
              // Buttons demonstrating context.read() and context.watch()
              ActionButtonsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget that subscribes via context.watch()
class WatchDisplayWidget extends StatelessWidget {
  const WatchDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch() causes WatchDisplayWidget to rebuild whenever ClickCountNotifier changes
    final notifier = context.watch<ClickCountNotifier>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Column(
        children: [
          const Text(
            'Observed via context.watch<ClickCountNotifier>()',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          const SizedBox(height: 10),
          Text(
            'Total Clicks: ${notifier.clicks}',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}

/// Widget containing action buttons
class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          icon: const Icon(Icons.touch_app),
          label: const Text('Increment using context.read() in callback'),
          onPressed: () {
            // context.read() retrieves the notifier without subscribing this button widget to rebuilds
            context.read<ClickCountNotifier>().addClick();
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text('Reset using context.read()'),
          onPressed: () {
            context.read<ClickCountNotifier>().reset();
          },
        ),
      ],
    );
  }
}
