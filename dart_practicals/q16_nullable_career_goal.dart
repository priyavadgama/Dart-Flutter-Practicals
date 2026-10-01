/// Practical 16:
/// Write a program that declares a nullable variable for your future career goal
/// (initially null), then use ?? to provide a default value, and ??= to assign
/// your actual goal afterward.

void main() {
  print('=== Practical 16: Null-Safety Operators (?? and ??=) ===\n');

  // Step 1: Declare a nullable variable initially null
  String? futureCareerGoal;

  print('1. Initial variable state: $futureCareerGoal');

  // Step 2: Use if-null operator (??) to display a default value
  String displayedGoal = futureCareerGoal ?? 'Exploring Technology & Engineering';
  print('2. Displaying goal using ?? operator: "$displayedGoal"');
  print('   (Note: futureCareerGoal remains: $futureCareerGoal)');

  // Step 3: Use null-aware assignment operator (??=) to assign actual goal
  print('\n3. Applying ??= operator:');
  futureCareerGoal ??= 'Lead Mobile Application & AI Systems Architect';
  print('   Assigned goal: $futureCareerGoal');

  // Step 4: Demonstrating ??= won\'t overwrite an already assigned value
  futureCareerGoal ??= 'Another Career Choice';
  print('\n4. Attempting another ??= assignment:');
  print('   Goal remains unchanged: $futureCareerGoal');
}
