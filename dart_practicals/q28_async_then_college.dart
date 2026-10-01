// Practical 28: Asynchronous Programming using Future and .then()
// Write an async function fetchCollegeName that simulates a 2 second delay and returns
// college name; call it using .then() and print a message that prints immediately before delay completes.

import 'dart:async';

Future<String> fetchCollegeName() async {
  print('⏳ [Background]: Contacting college academic server...');
  // Simulate 2-second network latency
  await Future.delayed(const Duration(seconds: 2));
  return 'Faculty of Science, Atmiya University, Rajkot';
}

void main() {
  print('========================================');
  print('Practical 28: Future & .then() Callback');
  print('========================================');

  print('1. [Main Thread]: Initiating asynchronous fetch request...');

  // Initiating async call using .then() callback
  fetchCollegeName().then((college) {
    print('3. [Future Resolved]: College Name received: "$college"');
    print('----------------------------------------');
    print('Done: Future execution pipeline completed.');
  }).catchError((error) {
    print('Error occurred: $error');
  });

  // This line runs synchronously and immediately before the 2-second delay finishes
  print('2. [Main Thread]: Non-blocking execution! This message prints IMMEDIATELY while the Future is still pending.');
}
