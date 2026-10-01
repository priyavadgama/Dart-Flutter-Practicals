// Practical 26: Mixins in Dart
// Define three mixins named after three real skills (Cooking, Drawing, Coding)
// and apply all three to a class named MySkills representing yourself; call all three in main().

mixin Coding {
  void writeCode() {
    print('💻 [Coding Mixin]: Architecting cross-platform Flutter & Dart applications with clean code principles.');
  }
}

mixin Drawing {
  void sketchArt() {
    print('🎨 [Drawing Mixin]: Crafting digital UI wireframes, vector illustrations, and artistic sketches.');
  }
}

mixin Cooking {
  void prepareMeal() {
    print('🍳 [Cooking Mixin]: Preparing delicious Italian pasta and traditional Indian spiced masala chai.');
  }
}

// Class MySkills representing the student, applying all 3 mixins via 'with'
class MySkills with Coding, Drawing, Cooking {
  final String studentName;
  final int rollNumber;

  MySkills({required this.studentName, required this.rollNumber});

  void introduce() {
    print('Hey! I am $studentName (Roll No: $rollNumber). Here are my multi-disciplinary skills:');
  }
}

void main() {
  print('========================================');
  print('Practical 26: Multi-Mixin Composition');
  print('========================================');

  final priyaProfile = MySkills(studentName: 'Vadgama Priya Ashokbhai', rollNumber: 35);
  priyaProfile.introduce();
  print('----------------------------------------');

  // Invoking methods from all three mixins
  priyaProfile.writeCode();
  priyaProfile.sketchArt();
  priyaProfile.prepareMeal();
}
