// Practical 3: Day Messages using Switch Statement
// Prints a specific message for each day of the current week starting from Monday.

void main() {
  print('========================================');
  print('Practical 3: Weekly Routine via Switch');
  print('========================================');

  // Days of current week
  final daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  for (var day in daysOfWeek) {
    String message;
    switch (day) {
      case 'Monday':
        message = 'Kickstart the week with Mobile Application Development lab!';
        break;
      case 'Tuesday':
        message = 'Deep dive into Dart asynchronous programming and streams.';
        break;
      case 'Wednesday':
        message = 'Mid-week sprint: Flutter UI and state management architectures.';
        break;
      case 'Thursday':
        message = 'Database integration practicals with SQLite & Hive.';
        break;
      case 'Friday':
        message = 'Reviewing pull requests, running test suites, and project submissions.';
        break;
      case 'Saturday':
        message = 'Weekend hackathon, competitive coding, and personal tech exploration.';
        break;
      case 'Sunday':
        message = 'Rest, family time, and planning goals for the upcoming academic week.';
        break;
      default:
        message = 'Standard study routine.';
    }
    print('$day: $message');
  }
}
