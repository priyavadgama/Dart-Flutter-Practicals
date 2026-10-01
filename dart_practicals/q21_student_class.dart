/// Practical 21:
/// Write a class Student with your own name, roll number, and marks for 3 subjects
/// as fields, a constructor, and a method that calculates and prints the average and grade.

class Student {
  final String name;
  final int rollNumber;
  final double subject1Marks;
  final double subject2Marks;
  final double subject3Marks;

  // Constructor
  Student({
    required this.name,
    required this.rollNumber,
    required this.subject1Marks,
    required this.subject2Marks,
    required this.subject3Marks,
  });

  // Calculate Average Marks
  double calculateAverage() {
    return (subject1Marks + subject2Marks + subject3Marks) / 3.0;
  }

  // Determine Grade based on average
  String calculateGrade(double average) {
    if (average >= 90) return 'A+ (Outstanding)';
    if (average >= 80) return 'A (Excellent)';
    if (average >= 70) return 'B (Very Good)';
    if (average >= 60) return 'C (Good)';
    if (average >= 50) return 'D (Pass)';
    return 'F (Fail)';
  }

  // Method to display results
  void printReportCard() {
    double totalMarks = subject1Marks + subject2Marks + subject3Marks;
    double average = calculateAverage();
    String grade = calculateGrade(average);

    print('==================================================');
    print('                STUDENT REPORT CARD               ');
    print('==================================================');
    print('Student Name   : $name');
    print('Roll Number    : $rollNumber');
    print('--------------------------------------------------');
    print('Subject 1 Marks: ${subject1Marks.toStringAsFixed(1)} / 100');
    print('Subject 2 Marks: ${subject2Marks.toStringAsFixed(1)} / 100');
    print('Subject 3 Marks: ${subject3Marks.toStringAsFixed(1)} / 100');
    print('--------------------------------------------------');
    print('Total Marks    : ${totalMarks.toStringAsFixed(1)} / 300');
    print('Average Marks  : ${average.toStringAsFixed(2)}%');
    print('Final Grade    : $grade');
    print('==================================================\n');
  }
}

void main() {
  print('=== Practical 21: Student Class with Grade Calculation ===\n');

  // Creating student instance with personal details
  Student smit = Student(
    name: 'Vadgama Priya Ashokbhai',
    rollNumber: 35,
    subject1Marks: 94.0, // Mobile Application Development
    subject2Marks: 88.5, // Data Structures
    subject3Marks: 91.0, // Database Systems
  );

  smit.printReportCard();
}
