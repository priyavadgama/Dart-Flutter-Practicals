/// Practical 23:
/// Create a parent class Person and a child class Teacher that extends it,
/// where Teacher overrides one method from Person; use your own name and
/// your favourite teacher's subject as field values.

// Parent Class
class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  // Base method to be overridden
  void introduce() {
    print('Hello, I am $name, and I am $age years old.');
  }

  void roleDescription() {
    print('$name is an academic member of the institution.');
  }
}

// Child Class extending Person
class Teacher extends Person {
  final String subject;
  final int yearsOfExperience;

  Teacher({
    required super.name,
    required super.age,
    required this.subject,
    required this.yearsOfExperience,
  });

  // Overriding introduce() method from Person
  @override
  void introduce() {
    print('Greetings! I am Professor $name.');
    print('I specialize in teaching "$subject" with $yearsOfExperience years of experience.');
  }

  void conductLecture() {
    print('Professor $name is currently conducting a session on $subject.');
  }
}

void main() {
  print('=== Practical 23: Inheritance & Method Overriding (Person -> Teacher) ===\n');

  // Parent class instance
  Person generalPerson = Person(name: 'Vadgama Priya Ashokbhai', age: 20);
  print('--- Parent Class (Person) ---');
  generalPerson.introduce();
  generalPerson.roleDescription();

  print('\n--- Child Class (Teacher) overriding introduce() ---');
  // Child class instance using student name and favourite teacher subject
  Teacher instructor = Teacher(
    name: 'Vadgama Priya Ashokbhai',
    age: 32,
    subject: 'Cross-Platform Mobile Application Development (Flutter)',
    yearsOfExperience: 8,
  );

  instructor.introduce(); // Calls overridden method
  instructor.roleDescription(); // Inherited method
  instructor.conductLecture(); // Subclass specific method
}
