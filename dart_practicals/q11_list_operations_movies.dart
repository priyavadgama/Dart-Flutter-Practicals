// Practical 11: List Operations (add, remove, sort)
// Create a List of 5 favourite movies or songs, use add, remove, and sort methods,
// and print the list after each operation.

void main() {
  print('========================================');
  print('Practical 11: List Methods (add, remove, sort)');
  print('========================================');

  // Initial list of 5 favourite movies
  List<String> favouriteMovies = [
    'Interstellar',
    'Inception',
    'The Dark Knight',
    'Oppenheimer',
    'Spider-Man: Across the Spider-Verse'
  ];

  print('1. Initial List (5 Movies):');
  print('   $favouriteMovies\n');

  // Operation 1: add a new movie
  favouriteMovies.add('Avengers: Endgame');
  print('2. After add("Avengers: Endgame"):');
  print('   $favouriteMovies\n');

  // Operation 2: remove an existing movie
  favouriteMovies.remove('Inception');
  print('3. After remove("Inception"):');
  print('   $favouriteMovies\n');

  // Operation 3: sort alphabetically
  favouriteMovies.sort();
  print('4. After sort() (Alphabetical Order):');
  print('   $favouriteMovies\n');

  print('----------------------------------------');
  print('Final Movie Count: ${favouriteMovies.length}');
  for (int i = 0; i < favouriteMovies.length; i++) {
    print('  #${i + 1}: ${favouriteMovies[i]}');
  }
}
