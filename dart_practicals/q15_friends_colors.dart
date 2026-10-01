/// Practical 15:
/// Write a program with a Map of at least 5 of your friends' names as keys and
/// their favourite colours as values; use putIfAbsent to add yourself with your
/// own favourite colour.

void main() {
  print('=== Practical 15: Friends and Favourite Colours Map ===\n');

  // Map of 5 friends and their favourite colours
  Map<String, String> friendsColours = {
    'Aarav': 'Crimson Red',
    'Rohan': 'Emerald Green',
    'Neha': 'Royal Purple',
    'Priya': 'Sunset Orange',
    'Kavya': 'Golden Yellow',
  };

  print('Initial Map of Friends:');
  friendsColours.forEach((name, colour) {
    print('- $name -> $colour');
  });

  print('\nAdding myself (Priya) using putIfAbsent()...');
  // putIfAbsent adds the key-value pair only if the key doesn't already exist
  friendsColours.putIfAbsent('Priya', () => 'Navy Blue');

  // Demonstrating that calling it again with an existing key does not overwrite
  friendsColours.putIfAbsent('Priya', () => 'Black');

  print('\nUpdated Map after putIfAbsent:');
  friendsColours.forEach((name, colour) {
    print('- $name -> $colour');
  });
}
