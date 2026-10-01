// Practical 29: Sequential Async Execution with async/await
// Simulates fetching own name, then roll number, then final result in sequence,
// each with a 1 second delay, printing each value as it becomes available.

import 'dart:async';

Future<String> fetchStudentName() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Vadgama Priya Ashokbhai';
}

Future<int> fetchRollNumber() async {
  await Future.delayed(const Duration(seconds: 1));
  return 35;
}

Future<String> fetchFinalResult() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Distinction (CPI: 9.15, Percentage: 88.5%)';
}

Future<void> main() async {
  print('========================================');
  print('Practical 29: Sequential async/await');
  print('========================================');
  print('Fetching academic records in sequence with 1-second simulated delay each...\n');

  final stopwatch = Stopwatch()..start();

  // Step 1: Fetch Name
  print('Step 1: Requesting Student Name...');
  final name = await fetchStudentName();
  print('  -> Received Name: $name (Elapsed: ${stopwatch.elapsedMilliseconds} ms)\n');

  // Step 2: Fetch Roll Number
  print('Step 2: Requesting Roll Number...');
  final roll = await fetchRollNumber();
  print('  -> Received Roll Number: $roll (Elapsed: ${stopwatch.elapsedMilliseconds} ms)\n');

  // Step 3: Fetch Final Result
  print('Step 3: Requesting Final Result...');
  final result = await fetchFinalResult();
  print('  -> Received Result: $result (Elapsed: ${stopwatch.elapsedMilliseconds} ms)\n');

  stopwatch.stop();

  print('----------------------------------------');
  print('ALL DATA RETRIEVED SUCCESSFULLY:');
  print('  Candidate : $name (Roll: $roll)');
  print('  Outcome   : $result');
  print('  Total Time: ${(stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(2)} seconds');
}
