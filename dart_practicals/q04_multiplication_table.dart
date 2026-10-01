// Practical 4: Multiplication Table via For Loop
// Prints the multiplication table (1 to 10) of the last digit of roll number.
// Student: Vadgama Priya Ashokbhai | Roll Number: 35 -> Last Digit: 5

void main() {
  print('========================================');
  print('Practical 4: Multiplication Table');
  print('========================================');

  const int rollNumber = 35;
  final int lastDigit = rollNumber % 10; // 35 % 10 = 5

  print('Student Roll Number: $rollNumber');
  print('Last Digit         : $lastDigit');
  print('--- Multiplication Table of $lastDigit ---');

  for (int i = 1; i <= 10; i++) {
    int product = lastDigit * i;
    print('$lastDigit x $i = $product');
  }

  // Also bonus illustration for complete roll number (35)
  print('----------------------------------------');
  print('--- Bonus: Table for Full Roll (35) ---');
  for (int i = 1; i <= 10; i++) {
    print('$rollNumber x $i = ${rollNumber * i}');
  }
}
