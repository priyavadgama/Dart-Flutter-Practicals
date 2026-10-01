// Practical 5: Even Numbers via While Loop
// Prints all even numbers between 1 and student roll number (35 as upper limit).

void main() {
  print('========================================');
  print('Practical 5: Even Numbers Using While');
  print('========================================');

  const int rollNumber = 35;
  int current = 1;
  List<int> evenList = [];

  print('Upper limit (Roll Number): $rollNumber');
  print('Even numbers between 1 and $rollNumber:');

  while (current <= rollNumber) {
    if (current % 2 == 0) {
      evenList.add(current);
      print('Even number: $current');
    }
    current++;
  }

  print('----------------------------------------');
  print('Found ${evenList.length} even numbers: ${evenList.join(', ')}');
}
