import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Easy Level - Practical 9:
/// Create a simple CounterModel using ChangeNotifier and display its value using a Consumer widget.

// ChangeNotifier Model
class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Q09ConsumerCounterScreen(),
      ),
    ),
  );
}

class Q09ConsumerCounterScreen extends StatelessWidget {
  const Q09ConsumerCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Easy Q9: ChangeNotifier & Consumer'),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Count value watched via Consumer<CounterModel>:',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Consumer Widget displays the value when model notifies listeners
              Consumer<CounterModel>(
                builder: (context, counterModel, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    child: Text(
                      '${counterModel.count}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              // Buttons calling model methods
              Consumer<CounterModel>(
                builder: (context, model, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        heroTag: 'consumer_dec',
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        onPressed: model.decrement,
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      IconButton.filledTonal(
                        onPressed: model.reset,
                        icon: const Icon(Icons.refresh),
                      ),
                      const SizedBox(width: 20),
                      FloatingActionButton(
                        heroTag: 'consumer_inc',
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        onPressed: model.increment,
                        child: const Icon(Icons.add),
                      ),
                    ],
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
