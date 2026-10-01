// Practical 6: Simple Interest Function
// Write calculateSimpleInterest(principal, rate, time) returning simple interest,
// then call with 3 different sets of values and print results.

double calculateSimpleInterest(double principal, double rate, double time) {
  // Simple Interest formula: SI = (P * R * T) / 100
  return (principal * rate * time) / 100.0;
}

void main() {
  print('========================================');
  print('Practical 6: Simple Interest Calculator');
  print('========================================');

  // Test Case 1: College Tuition Loan
  double p1 = 50000.0;
  double r1 = 7.5;
  double t1 = 3.0;
  double si1 = calculateSimpleInterest(p1, r1, t1);
  print('Case 1 (Education Loan):');
  print('  Principal: ₹$p1, Rate: $r1%, Time: $t1 years');
  print('  Interest : ₹${si1.toStringAsFixed(2)} | Total: ₹${(p1 + si1).toStringAsFixed(2)}');
  print('----------------------------------------');

  // Test Case 2: Laptop Purchase EMI / Personal Loan
  double p2 = 85000.0;
  double r2 = 9.25;
  double t2 = 2.0;
  double si2 = calculateSimpleInterest(p2, r2, t2);
  print('Case 2 (Laptop Purchase):');
  print('  Principal: ₹$p2, Rate: $r2%, Time: $t2 years');
  print('  Interest : ₹${si2.toStringAsFixed(2)} | Total: ₹${(p2 + si2).toStringAsFixed(2)}');
  print('----------------------------------------');

  // Test Case 3: Fixed Deposit Investment
  double p3 = 120000.0;
  double r3 = 6.8;
  double t3 = 5.0;
  double si3 = calculateSimpleInterest(p3, r3, t3);
  print('Case 3 (Fixed Deposit):');
  print('  Principal: ₹$p3, Rate: $r3%, Time: $t3 years');
  print('  Interest : ₹${si3.toStringAsFixed(2)} | Total: ₹${(p3 + si3).toStringAsFixed(2)}');
}
