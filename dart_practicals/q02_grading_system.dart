// Practical 2: Grading System using If-Else
// Takes last exam percentage (hardcoded) and prints the actual grade based on college grading rules.

void main() {
  print('========================================');
  print('Practical 2: Exam Grade Calculation');
  print('========================================');

  // Hardcoded last semester exam percentage
  const double examPercentage = 88.5;
  String grade;
  String remarks;

  if (examPercentage >= 90.0) {
    grade = 'A+ (Distinction)';
    remarks = 'Outstanding performance!';
  } else if (examPercentage >= 80.0) {
    grade = 'A (First Class with Distinction)';
    remarks = 'Excellent work!';
  } else if (examPercentage >= 70.0) {
    grade = 'B (First Class)';
    remarks = 'Very good result!';
  } else if (examPercentage >= 60.0) {
    grade = 'C (Higher Second Class)';
    remarks = 'Good, keep improving!';
  } else if (examPercentage >= 50.0) {
    grade = 'D (Second Class / Pass)';
    remarks = 'Cleared the examination.';
  } else {
    grade = 'F (Fail)';
    remarks = 'Needs re-examination.';
  }

  print('Student Name   : Vadgama Priya Ashokbhai');
  print('Roll Number    : 35');
  print('Exam Percentage: $examPercentage%');
  print('Final Grade    : $grade');
  print('Remarks        : $remarks');
}
