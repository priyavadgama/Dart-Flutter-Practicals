/// Practical 22:
/// Write a class Book with named and default named constructors, where the default
/// constructor sets the book title to a book you are currently reading or have recently read.

class Book {
  final String title;
  final String author;
  final double price;

  // Default constructor (sets title to currently/recently read book)
  Book({
    this.title = 'Atomic Habits',
    this.author = 'James Clear',
    this.price = 499.0,
  });

  // Named constructor 1: fromTitleAndAuthor
  Book.withAuthor(this.title, this.author) : price = 350.0;

  // Named constructor 2: full details
  Book.custom({
    required this.title,
    required this.author,
    required this.price,
  });

  void displayInfo() {
    print('Book Title : "$title"');
    print('Author     : $author');
    print('Price      : ₹${price.toStringAsFixed(2)}');
    print('--------------------------------------------------');
  }
}

void main() {
  print('=== Practical 22: Book Class Constructors ===\n');

  print('1. Instantiating via Default Constructor (currently reading book):');
  Book currentBook = Book();
  currentBook.displayInfo();

  print('2. Instantiating via Named Constructor "Book.withAuthor":');
  Book flutterBook = Book.withAuthor('Flutter in Action', 'Eric Windmill');
  flutterBook.displayInfo();

  print('3. Instantiating via Named Constructor "Book.custom":');
  Book algoBook = Book.custom(
    title: 'Clean Architecture',
    author: 'Robert C. Martin',
    price: 650.0,
  );
  algoBook.displayInfo();
}
