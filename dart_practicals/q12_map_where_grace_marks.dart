// Practical 12: List Transformation with map and where
// List of marks for 6 subjects, use map to add 5 grace marks to each,
// and where to filter out subjects where marks are below 50.

void main() {
  print('========================================');
  print('Practical 12: map() and where() Methods');
  print('========================================');

  // Original list of marks in 6 subjects
  final List<int> originalMarks = [78, 46, 92, 42, 85, 48];
  print('Original Subject Marks (6 Subjects):');
  print('  $originalMarks\n');

  // Step 1: Use map to add 5 grace marks to each subject
  final List<int> marksWithGrace = originalMarks.map((marks) => marks + 5).toList();
  print('Marks after adding 5 Grace Marks (via map):');
  print('  $marksWithGrace\n');

  // Step 2: Use where to filter subjects where marks scored below 50
  // Note: Filtering out < 50 means keeping passing subjects (>= 50),
  // and identifying which ones were below 50.
  final List<int> passedMarks = marksWithGrace.where((m) => m >= 50).toList();
  final List<int> failedMarks = marksWithGrace.where((m) => m < 50).toList();

  print('Subjects with Passing Marks (>= 50 after grace):');
  print('  $passedMarks (Count: ${passedMarks.length})\n');

  print('Filtered Out Subjects (Below 50 even after grace):');
  print('  $failedMarks (Count: ${failedMarks.length})\n');

  print('----------------------------------------');
  print('Summary:');
  for (int i = 0; i < originalMarks.length; i++) {
    int orig = originalMarks[i];
    int withGrace = marksWithGrace[i];
    String status = withGrace >= 50 ? 'PASSED' : 'NEEDS IMPROVEMENT';
    print('  Subject ${i + 1}: Orig: $orig -> With Grace: $withGrace ($status)');
  }
}
