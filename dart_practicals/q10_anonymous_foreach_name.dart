// Practical 10: Anonymous Function in forEach
// Program using an anonymous function inside forEach that prints each letter
// of own first name ('Priya') on a separate line.

void main() {
  print('========================================');
  print('Practical 10: Anonymous Function forEach');
  print('========================================');

  const String firstName = 'Priya';

  // Split name string into a list of individual characters
  List<String> characters = firstName.split('');

  print('Printing letters of "$firstName" using anonymous lambda in forEach:');

  int index = 1;
  // Anonymous function: (char) { ... }
  characters.forEach((char) {
    print('  Letter $index: $char');
    index++;
  });

  print('----------------------------------------');
  print('Total letters processed: ${characters.length}');
}
