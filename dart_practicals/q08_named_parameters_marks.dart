// Practical 8: Named Parameters
// Function using named parameters printing subject marks for at least 4 subjects of current semester.

void displaySemesterMarks({
  required String studentName,
  required int rollNumber,
  required double mobileAppDev,
  required double cloudComputing,
  required double artificialIntelligence,
  required double cyberSecurity,
  double? devOps,
}) {
  print('Student Name : $studentName');
  print('Roll Number  : $rollNumber');
  print('Semester     : Semester V');
  print('----------------------------------------');
  print('Subject-wise Marks:');
  print('  1. Mobile Application Development : $mobileAppDev / 100');
  print('  2. Cloud Computing                 : $cloudComputing / 100');
  print('  3. Artificial Intelligence & ML    : $artificialIntelligence / 100');
  print('  4. Cyber Security & Forensics      : $cyberSecurity / 100');
  if (devOps != null) {
    print('  5. DevOps & CI/CD Elective         : $devOps / 100');
  }

  double total = mobileAppDev + cloudComputing + artificialIntelligence + cyberSecurity + (devOps ?? 0);
  int count = devOps != null ? 5 : 4;
  double average = total / count;

  print('----------------------------------------');
  print('Total Marks : $total / ${count * 100}');
  print('Average     : ${average.toStringAsFixed(2)}%');
  print('Result      : ${average >= 50.0 ? "PASSED WITH DISTINCTION" : "FAILED"}');
}

void main() {
  print('========================================');
  print('Practical 8: Named Parameters for Marks');
  print('========================================');

  // Calling function using named parameters in any order
  displaySemesterMarks(
    studentName: 'Vadgama Priya Ashokbhai',
    rollNumber: 35,
    mobileAppDev: 92.5,
    cloudComputing: 86.0,
    artificialIntelligence: 89.0,
    cyberSecurity: 84.5,
    devOps: 90.0,
  );
}
