import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Hard Level - Practical 4:
/// Build a simple Counter App using the BLoC pattern (flutter_bloc)
/// that handles Increment and Decrement Events.

// 1. Events
abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

class ResetCounterEvent extends CounterEvent {}

// 2. Bloc Logic
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementCounterEvent>((event, emit) => emit(state + 1));
    on<DecrementCounterEvent>((event, emit) => emit(state - 1));
    on<ResetCounterEvent>((event, emit) => emit(0));
  }
}

void main() {
  runApp(
    BlocProvider(
      create: (_) => CounterBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Q04CounterBlocScreen(),
      ),
    ),
  );
}

// 3. UI Screen
class Q04CounterBlocScreen extends StatelessWidget {
  const Q04CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hard Q4: Counter with flutter_bloc'),
          backgroundColor: Colors.blueGrey.shade900,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bloc State (Counter Value):',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // BlocBuilder listens to state emissions
              BlocBuilder<CounterBloc, int>(
                builder: (context, count) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blueGrey.shade700, width: 2),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 36),
              // Action buttons dispatching Events to Bloc
              Builder(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        heroTag: 'bloc_dec',
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          // Dispatch DecrementCounterEvent
                          context.read<CounterBloc>().add(DecrementCounterEvent());
                        },
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 24),
                      IconButton.filledTonal(
                        onPressed: () {
                          // Dispatch ResetCounterEvent
                          context.read<CounterBloc>().add(ResetCounterEvent());
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                      const SizedBox(width: 24),
                      FloatingActionButton(
                        heroTag: 'bloc_inc',
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          // Dispatch IncrementCounterEvent
                          context.read<CounterBloc>().add(IncrementCounterEvent());
                        },
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
