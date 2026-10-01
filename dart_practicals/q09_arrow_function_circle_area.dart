// Practical 9: Arrow Function for Circle Area
// Convert normal function calculating circle area into an arrow function,
// and calculate area for 3 different radius values.

import 'dart:math';

// Normal function (commented for comparison):
// double calculateAreaNormal(double radius) {
//   return pi * radius * radius;
// }

// Converted to Arrow Syntax (fat-arrow =>):
double calculateCircleArea(double radius) => pi * radius * radius;

void main() {
  print('========================================');
  print('Practical 9: Circle Area (Arrow Function)');
  print('========================================');

  // 3 radius values of choice
  final radii = [3.5, 7.0, 14.2];

  for (int i = 0; i < radii.length; i++) {
    double r = radii[i];
    double area = calculateCircleArea(r);
    print('Radius ${i + 1}: $r cm -> Area = ${area.toStringAsFixed(3)} sq cm');
  }
}
