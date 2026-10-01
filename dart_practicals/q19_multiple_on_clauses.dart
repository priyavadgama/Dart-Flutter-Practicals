/// Practical 19:
/// Write a program with multiple on clauses that attempts to parse your own name
/// (a String) as an integer using int.parse, and separately attempts to access
/// an out-of-range index in a list of your 3 favourite foods, printing different
/// messages for each.

void main() {
  print('=== Practical 19: Multiple "on" Exception Handling Clauses ===\n');

  String myName = 'Priya';
  List<String> favouriteFoods = ['Paneer Butter Masala', 'Dosa', 'Pizza'];

  // Test Case 1: FormatException when parsing name as integer
  print('--- Test 1: Parsing Name String as Integer ---');
  try {
    print('Attempting to parse "$myName" using int.parse()...');
    int parsedNumber = int.parse(myName);
    print('Parsed value: $parsedNumber');
  } on FormatException catch (e) {
    print('CAUGHT FormatException: Unable to parse string "$myName" into an integer.');
    print('Message: Names contain alphabets, which cannot be converted to numeric digits ($e).\n');
  } on RangeError catch (e) {
    print('CAUGHT RangeError: List index boundary issue ($e).\n');
  } catch (e) {
    print('CAUGHT Generic Exception: $e\n');
  }

  // Test Case 2: RangeError when accessing out-of-range list index
  print('--- Test 2: Accessing Invalid Index in Foods List ---');
  try {
    print('Favourite foods list (length ${favouriteFoods.length}): $favouriteFoods');
    print('Attempting to access index 5 in the list...');
    String selectedFood = favouriteFoods[5];
    print('Food at index 5: $selectedFood');
  } on FormatException catch (e) {
    print('CAUGHT FormatException: String conversion failure ($e).\n');
  } on RangeError catch (e) {
    print('CAUGHT RangeError: Attempted to access index out of valid range (0 to ${favouriteFoods.length - 1}).');
    print('Message: Invalid index access intercepted: ${e.message} (value: ${e.invalidValue}).\n');
  } catch (e) {
    print('CAUGHT Generic Exception: $e\n');
  }

  print('Program completed gracefully with specific on handlers.');
}
