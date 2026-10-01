/// Practical 20:
/// Create a custom exception class named LowAttendanceException that stores
/// a student's name and attendance percentage; write a function checkAttendance
/// that throws this exception if attendance is below 75 percent, and test it
/// with your own (hypothetical) attendance percentage.

// Custom Exception Class
class LowAttendanceException implements Exception {
  final String studentName;
  final double attendancePercentage;

  LowAttendanceException(this.studentName, this.attendancePercentage);

  @override
  String toString() {
    return 'LowAttendanceException: Attendance for student "$studentName" is only ${attendancePercentage.toStringAsFixed(1)}%, which is below the mandatory 75.0% threshold!';
  }
}

// Function to validate student attendance
void checkAttendance(String name, double percentage) {
  print('Validating attendance for $name: ${percentage.toStringAsFixed(1)}%...');
  if (percentage < 75.0) {
    throw LowAttendanceException(name, percentage);
  }
  print('SUCCESS: $name has satisfactory attendance (${percentage.toStringAsFixed(1)}%). Eligible for exams.\n');
}

void main() {
  print('=== Practical 20: Custom LowAttendanceException ===\n');

  // Test Case 1: Attendance below 75% (throws custom exception)
  try {
    double myLowAttendance = 68.5; // Hypothetical low attendance
    checkAttendance('Vadgama Priya Ashokbhai', myLowAttendance);
  } on LowAttendanceException catch (e) {
    print('ALERT: Custom Exception Caught!');
    print(e);
    print('Action Required: Submit medical certificate or attend remedial lectures.\n');
  }

  // Test Case 2: Attendance above 75% (valid)
  try {
    double myGoodAttendance = 88.0; // Satisfactory attendance
    checkAttendance('Vadgama Priya Ashokbhai', myGoodAttendance);
  } on LowAttendanceException catch (e) {
    print(e);
  }
}
