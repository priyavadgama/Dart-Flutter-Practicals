// Practical 7: Optional Positional Parameters
// Customized birthday wish function with own name ('Priya') and age (20) as default values.

void printBirthdayWish([String name = 'Priya', int age = 20, String customGreeting = 'Wishing you endless success & joy!']) {
  print('🎉🎂 HAPPY BIRTHDAY! 🎂🎉');
  print('Dear $name,');
  print('Congratulations on turning $age years old!');
  print('$customGreeting');
  print('----------------------------------------');
}

void main() {
  print('========================================');
  print('Practical 7: Optional Positional Parameters');
  print('========================================');

  // Call 1: With zero arguments (uses all default values: Priya, 20)
  print('--- Test 1: Using All Default Values ---');
  printBirthdayWish();

  // Call 2: Overriding the first positional argument (name)
  print('--- Test 2: Passing Custom Name Only ---');
  printBirthdayWish('Aarav');

  // Call 3: Overriding name and age
  print('--- Test 3: Passing Custom Name and Age ---');
  printBirthdayWish('Priya', 22);

  // Call 4: Overriding all 3 optional positional arguments
  print('--- Test 4: Passing All Arguments ---');
  printBirthdayWish('Prof. Sharma', 45, 'Thank you for inspiring us every single day!');
}
