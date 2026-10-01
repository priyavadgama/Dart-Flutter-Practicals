// Practical 18: Try-Catch Block with Division by Zero
// Write a program with a try-catch block that deliberately divides your roll number
// by zero and prints a custom error message including your roll number.

void main() {
  print('========================================');
  print('Practical 18: Try-Catch Division by Zero');
  print('========================================');

  int myRollNumber = 35; // Priya's Roll Number
  int divisor = 0;

  try {
    print('Attempting integer division: $myRollNumber ~/ $divisor ...');
    // Using ~/ which throws UnsupportedError on division by zero in Dart VM
    int result = myRollNumber ~/ divisor;
    print('Result: $result');
  } catch (e) {
    print('\n[CAUGHT EXCEPTION]:');
    print('Error: Cannot divide Roll Number ($myRollNumber) by zero!');
    print('Exception details: $e');
  } finally {
    print('\n[Finally Block]: Clean-up executed regardless of exception.');
    print('Student Roll No $myRollNumber verified.');
  }
}
