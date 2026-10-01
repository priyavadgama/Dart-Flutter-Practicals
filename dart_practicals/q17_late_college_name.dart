/// Practical 17:
/// Write a program demonstrating the late keyword for a variable storing your
/// college name, where the variable is declared at the top but assigned inside
/// a separate function.

// Top-level variable declared with 'late' keyword
// It is initialized lazily when first assigned before access
late String collegeName;

void initializeCollege() {
  print('-> initializeCollege() function called.');
  collegeName = 'Institute of Technology & Applied Science';
}

void main() {
  print('=== Practical 17: Demonstrating the "late" Keyword ===\n');

  print('Program started. "late String collegeName" is declared at top level.');
  print('Calling separate function to initialize collegeName...');

  initializeCollege();

  // Accessing the variable after initialization
  print('\nCollege Name successfully accessed:');
  print('College: $collegeName');
}
