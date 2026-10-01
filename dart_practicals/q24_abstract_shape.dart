/// Practical 24:
/// Write an abstract class Shape with abstract methods area() and perimeter();
/// implement it in two subclasses for any two shapes of your choice
/// (not Circle and Rectangle) with values you decide.

import 'dart:math';

// Abstract Class
abstract class Shape {
  final String shapeName;

  Shape(this.shapeName);

  // Abstract methods
  double area();
  double perimeter();

  void printDetails() {
    print('--- Shape: $shapeName ---');
    print('Calculated Area     : ${area().toStringAsFixed(2)} sq units');
    print('Calculated Perimeter: ${perimeter().toStringAsFixed(2)} units\n');
  }
}

// Subclass 1: Square (Not Circle, Not Rectangle)
class Square extends Shape {
  final double side;

  Square(this.side) : super('Square (side = $side)');

  @override
  double area() => side * side;

  @override
  double perimeter() => 4 * side;
}

// Subclass 2: RightTriangle (Not Circle, Not Rectangle)
class RightTriangle extends Shape {
  final double base;
  final double height;

  RightTriangle({required this.base, required this.height})
      : super('Right-Angled Triangle (base = $base, height = $height)');

  // Hypotenuse calculated using Pythagorean theorem: sqrt(b^2 + h^2)
  double get hypotenuse => sqrt((base * base) + (height * height));

  @override
  double area() => 0.5 * base * height;

  @override
  double perimeter() => base + height + hypotenuse;
}

// Subclass 3: EquilateralTriangle (Extra bonus demonstration)
class EquilateralTriangle extends Shape {
  final double side;

  EquilateralTriangle(this.side)
      : super('Equilateral Triangle (side = $side)');

  @override
  double area() => (sqrt(3) / 4) * side * side;

  @override
  double perimeter() => 3 * side;
}

void main() {
  print('=== Practical 24: Abstract Class Shape and Subclasses ===\n');

  List<Shape> shapes = [
    Square(6.0),
    RightTriangle(base: 3.0, height: 4.0),
    EquilateralTriangle(5.0),
  ];

  for (var s in shapes) {
    s.printDetails();
  }
}
