// Practical 1: Variables and String Interpolation
// Declare name, roll number, and city using var, final, and const respectively,
// then print all three using string interpolation.

void main() {
  print('========================================');
  print('Practical 1: Variables & Interpolation');
  print('========================================');

  // Declared using 'var' (type inferred as String)
  var studentName = 'Vadgama Priya Ashokbhai';

  // Declared using 'final' (runtime constant)
  final int rollNumber = 35;

  // Declared using 'const' (compile-time constant)
  const String city = 'Rajkot';

  // Printing using String Interpolation
  print('Student Name  (var)   : $studentName');
  print('Roll Number   (final) : $rollNumber');
  print('City          (const) : $city');
  print('----------------------------------------');
  print('Summary: Hi, I am $studentName (Roll No: $rollNumber) from $city.');
}
