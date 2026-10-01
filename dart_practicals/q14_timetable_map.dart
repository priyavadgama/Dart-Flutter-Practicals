/// Practical 14:
/// Create a Map that stores your weekly timetable (day as key, subject as value,
/// for at least 5 days), then print it using forEach in the format 'Day: Subject'.

void main() {
  print('=== Practical 14: Weekly Timetable Map ===\n');

  // Timetable map storing Day -> Subject
  Map<String, String> weeklyTimetable = {
    'Monday': 'Mobile Application Development (Flutter)',
    'Tuesday': 'Database Management Systems',
    'Wednesday': 'Data Structures & Algorithms',
    'Thursday': 'Computer Networks & Security',
    'Friday': 'Cloud Computing & DevOps',
    'Saturday': 'Software Engineering Project Lab',
  };

  print('Weekly College Timetable:');
  print('--------------------------------------------------');

  // Iterating using forEach and printing in 'Day: Subject' format
  weeklyTimetable.forEach((day, subject) {
    print('$day: $subject');
  });
}
