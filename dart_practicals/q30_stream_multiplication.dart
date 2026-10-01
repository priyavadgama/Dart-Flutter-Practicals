// Practical 30: Reactive Programming using Dart Streams & async*
// Stream function emitting roll number multiplied by 1 to 5, one value per second,
// consumed using 'await for' loop in main, printing each with a label.

import 'dart:async';

Stream<Map<String, dynamic>> emitRollMultiplicationStream(int rollNumber) async* {
  for (int multiplier = 1; multiplier <= 5; multiplier++) {
    // Wait for 1 second between stream emissions
    await Future.delayed(const Duration(seconds: 1));
    int result = rollNumber * multiplier;
    yield {
      'multiplier': multiplier,
      'result': result,
      'timestamp': DateTime.now().toIso8601String().substring(11, 19),
    };
  }
}

Future<void> main() async {
  print('========================================');
  print('Practical 30: Dart Stream with async*');
  print('========================================');

  const int rollNumber = 35;
  print('Student Roll Number: $rollNumber');
  print('Listening to stream (emits 1 value per second for 5 iterations)...\n');

  final stream = emitRollMultiplicationStream(rollNumber);

  // Consuming stream reactively using 'await for' loop
  await for (final emission in stream) {
    int m = emission['multiplier'] as int;
    int res = emission['result'] as int;
    String time = emission['timestamp'] as String;

    print('[$time] Stream Event #$m: $rollNumber x $m = $res');
  }

  print('\n----------------------------------------');
  print('Stream finished: All 5 multiplication events successfully received.');
}
